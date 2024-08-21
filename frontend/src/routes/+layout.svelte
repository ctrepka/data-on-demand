<script lang="ts">
	import { duckDbInstance } from '$lib/duckdbInstanceStore';
	import '../app.css';
</script>

<main class="w-full h-full grid grid-rows-[auto_1fr_auto]">
	<header class="w-full p-3 bg-slate-700 text-white grid grid-cols-[auto_1fr] justify-between">
		<div>Header</div>
		<div class="grid justify-end">
			{#if $duckDbInstance.isInstantiated == false}
				<span>DuckDB Instantiating.</span>
			{:else}
				<span class="text-green-300">DuckDB Ready.</span>
			{/if}
		</div>
	</header>

	<div class="w-full pt-12 p-3 container mx-auto ">
		{#if $duckDbInstance.isInstantiated}
			<slot></slot>
		{/if}
	</div>
	<footer class="w-full p-3 bg-slate-900 text-white">footer</footer>
</main>

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
