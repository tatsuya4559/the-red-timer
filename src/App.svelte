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

<div class="m-8">
  <label class="text-xl">
    残り
    <input
      class="border border-black border-solid w-12 rounded"
      type="number"
      bind:value={remain} />
    分
  </label>
  <button
    class="px-4 py-2 bg-red-300 hover:bg-red-500 font-bold rounded text-gray-800
    shadow"
    on:click={start}>
    開始
  </button>
  <button
    class="px-4 py-2 bg-red-300 hover:bg-red-500 font-bold rounded text-gray-800
    shadow"
    on:click={stop}>
    停止
  </button>
  <button
    class="px-4 py-2 bg-red-300 hover:bg-red-500 font-bold rounded text-gray-800
    shadow"
    on:click={reset}>
    リセット
  </button>
</div>
<Clock {remain} />
