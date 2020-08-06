<script>
  import { afterUpdate, onDestroy } from 'svelte';
  import Clock from './Clock.svelte';

  class RemainTime {
    constructor(s) {
      this._sec = s;
    }
    get sec() {
      return this._sec;
    }
    set sec(s) {
      this._sec = s;
    }
    get min() {
      return Math.ceil(this._sec / 60)
    }
    set min(m) {
      this._sec = m * 60;
    }
  }
  let remain = new RemainTime(60 * 20);

  let timerId;
  function start() {
    timerId = setInterval(() => (remain.sec -= 1), 1000);
  }

  function stop() {
    clearInterval(timerId);
    timerId = undefined;
  }

  function reset() {
    remain.sec = 0;
  }

  let audio;
  let beepEnabled = true;
  afterUpdate(() => {
    if (remain.sec <= 0) {
      stop();
      beepEnabled && audio.play();
    }
  });

  onDestroy(() => {
    stop();
  });
</script>

<audio
  src="http://soundbible.com/mp3/service-bell_daniel_simion.mp3"
  bind:this={audio} />

<div class="mx-8 mt-4">
  <div class="my-4">
    <label class="text-xl">
      残り
      <input
        class="border border-black border-solid w-12 rounded"
        type="number"
        min="0"
        max="60"
        bind:value={remain.min} />
      分
    </label>
    <input type="range" min="0" max="60" bind:value={remain.min} />
    <label class="ml-4 text-xl">
      <input type="checkbox" bind:checked={beepEnabled} />
      アラーム音あり
    </label>
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
    class="px-4 py-2 bg-red-300 active:bg-red-500 font-bold rounded
    text-gray-800 shadow disabled:opacity-50 disabled:cursor-not-allowed"
    disabled={timerId}
    on:click={reset}>
    リセット
  </button>
  <Clock remain={remain.sec} />
</div>
