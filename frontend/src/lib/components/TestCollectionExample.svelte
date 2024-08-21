<script lang="ts">
	import { duckDbInstance } from '$lib/duckdbInstanceStore';
	import Result from 'postcss/lib/result';

	let result;

	const conn = duckDbInstance.connect().then(async (c) => {
		const res = await c?.query('INSTALL spatial; LOAD spatial;');
		const res2 = await c?.query(
			"DESCRIBE SELECT * FROM 's3://txgio-copc-test/stratmap24-addresspoints_48.parquet' LIMIT 1;"
		);
		result = { rows: res2.toArray().map((r) => r.toJSON()), fields: res2.schema.fields };
		console.log(res, res2, result);
	});
</script>

<h2 class="text-3xl font-semibold leading-loose">Data Dictionary</h2>
<table>
	{#if result}
		<tr
			>{#each result.fields as th}
				<th>{th.name} ({th.type})</th>
			{/each}</tr
		>

		{#each result.rows as tr}
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

<style>
    table, tr, td, th {
        padding: .5rem;
        border: solid 1px #ccc;
    }
</style>