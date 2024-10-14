<script lang="ts">
	import { duckDbInstance } from '$lib/duckdbInstanceStore';

	let dataDictionary;
	let queryResult;
	let loading = true;
	let dlLink = null;

	const conn = duckDbInstance.connect().then(async (c) => {
		const INSTALL_QUERY = await c?.query(
			'INSTALL spatial; LOAD spatial; INSTALL parquet; LOAD parquet;'
		);
		const DATA_DICT = await c?.query(
			"DESCRIBE SELECT * FROM 's3://txgio-copc-test/address_points_2024_county/*/*.parquet' LIMIT 1;"
		);
		const PREVIEW_TABLE = await c?.query(
			`DROP TABLE IF EXISTS preview; CREATE TABLE preview AS SELECT * FROM 's3://txgio-copc-test/stratmap24-addresspoints_48.parquet' LIMIT 100;`
		);
		const PREVIEW_EXPORT = await c?.query(`COPY preview TO 'data_preview.csv' (FORMAT CSV);`);
		const PREVIEW_QUERY = await c?.query(`SELECT * FROM preview;`);

		queryResult = {
			rows: PREVIEW_QUERY.toArray().map((r) => r.toJSON()),
			fields: PREVIEW_QUERY.schema.fields
		};
		dataDictionary = {
			rows: DATA_DICT.toArray().map((r) => r.toJSON()),
			fields: DATA_DICT.schema.fields
		};

		const pqBuf = await $duckDbInstance.db.copyFileToBuffer('data_preview.csv');

		dlLink = URL.createObjectURL(new Blob([pqBuf]));
		loading = false;
		//test
		c?.close();
		await $duckDbInstance.db?.dropFile('data_preview.csv');
	});
</script>

<section class="w-full mx-auto overflow-x-auto">
	<h2 class="text-3xl font-semibold leading-loose">Data Dictionary</h2>
	{#if loading}
		<div class="w-full mx-auto text-center font-bold">LOADING, PLEASE WAIT...</div>
	{/if}
	<div class="max-h-[400px] overflow-auto border-s-gray-100">
		<table class="w-full">
			{#if dataDictionary}
				<tr
					>{#each dataDictionary.fields as th}
						<th>{th.name} ({th.type})</th>
					{/each}</tr
				>

				{#each dataDictionary.rows as tr}
					<tr
						>{#each Object.values(tr) as val}
							<td>
								{val}
							</td>
						{/each}</tr
					>
				{/each}
			{/if}
		</table>
	</div>
	<h2 class="text-3xl font-semibold leading-loose">Preview Results (limit 100)</h2>
	{#if dlLink}
		<a
			href={dlLink}
			class="text-blue-600 visited:text-purple-600 font-bold"
			download="data_preview.csv">Download Preview CSV</a
		>
	{/if}
	{#if loading}
		<div class="w-full mx-auto text-center font-bold">LOADING, PLEASE WAIT...</div>
	{/if}
	<div class="max-h-[400px] overflow-auto">
		<table class="w-full">
			{#if queryResult}
				<tr
					>{#each queryResult.fields as th}
						<th>{th.name} ({th.type})</th>
					{/each}</tr
				>

				{#each queryResult.rows as tr}
					<tr
						>{#each Object.values(tr) as val}
							<td>
								{val}
							</td>
						{/each}</tr
					>
				{/each}
			{/if}
		</table>
	</div>
</section>

<style>
	table,
	tr,
	td,
	th {
		padding: 0.5rem;
		border: solid 1px #ccc;
	}
</style>
