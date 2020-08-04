<script>
  import { afterUpdate, onDestroy } from 'svelte';
  import Clock from './Clock.svelte';

  let remain = 20;

  let timerId;
  function start() {
    // 60秒ごとに刻む
    timerId = setInterval(() => (remain -= 1), 1000 * 60);
  }

  function stop() {
    clearInterval(timerId);
    timerId = undefined;
  }

  function reset() {
    remain = 0;
  }

  afterUpdate(() => {
    if (remain <= 0) {
      stop();
    }
  });

  onDestroy(() => {
    stop();
  });
</script>

<div class="mx-8 mt-4">
  <div class="my-4">
    <label class="text-xl">
      残り
      <input
        class="border border-black border-solid w-12 rounded"
        type=number
        min=0
        max=60
        bind:value={remain} />
      分
    </label>
    <input
      type=range
      min=0
      max=60
      bind:value={remain}
    />
  </div>
  {#if timerId}
    <button
      class="px-4 py-2 bg-red-300 active:bg-red-500 font-bold rounded
      text-gray-800 shadow"
      on:click={stop}>
      停止
    </button>
  {:else}
    <button
      class="px-4 py-2 bg-red-300 active:bg-red-500 font-bold rounded
      text-gray-800 shadow"
      on:click={start}>
      開始
    </button>
  {/if}

  <button
    class="px-4 py-2 bg-red-300 active:bg-red-500 font-bold rounded text-gray-800
    shadow disabled:opacity-50 disabled:cursor-not-allowed"
    disabled={timerId}
    on:click={reset}>
    リセット
  </button>
  <Clock {remain} />
</div>
