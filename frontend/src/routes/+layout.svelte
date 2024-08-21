<script lang="ts">
	import { duckDbInstance } from '$lib/duckdbInstanceStore';
	import '../app.css';
</script>

<div class="w-full h-full grid grid-rows-[auto_1fr_auto]">
	<header class="w-full h-full bg-slate-700 text-white">
		<div class="p-3 mx-auto container grid grid-cols-[auto_1fr] justify-between">
			<div>Header</div>
			<div class="grid justify-end">
				{#if $duckDbInstance.isInstantiated == false}
					<div>DuckDB Instantiating.</div>
				{:else}
					<div class="text-green-300">DuckDB Ready.</div>
				{/if}
			</div>
		</div>
	</header>

	<main class="w-full h-full py-2 pt-12 p-3 container mx-auto overflow-auto">
		{#if $duckDbInstance.isInstantiated}
			<slot></slot>
		{/if}
	</main>
	<footer class="w-full bg-slate-900 text-white">
		<div class="p-3 mx-auto container grid">Footer</div>
	</footer>
</div>

<style lang="postcss">
	:global(html, body) {
		background-color: theme(colors.gray.100);
		width: 100vw;
		height: 100vh;
		max-width: 100vw;
		max-height: 100vh;
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}
</style>
