<script>
  import { onMount, onDestroy, afterUpdate } from 'svelte';
  import Chart from 'chart.js';

  export let remain = 0;
  $: data = {
    labels: ['残り時間', '経過時間'],
    datasets: [
      {
        data: [remain, 60 - remain],
        backgroundColor: ['#FF0000', '#e0e0e0'],
      },
    ],
  };

  const options = {
    // グラフの太さ（中央部分を何％切り取るか）
    // cutoutPercentage: 40,
    // 凡例を表示しない
    legend: { display: false },
    // タイトル
    title: {
      display: true,
      fontSize: 32,
      text: '残り時間',
    },
    // マウスオーバー時に情報を表示しない
    tooltips: { enabled: false },
  };

  let ctx;
  let chart;
  onMount(() => {
    chart = new Chart(ctx, {
      type: 'pie',
      data: data,
      options: options,
    });
  });

  afterUpdate(() => {
    chart.data = data;
    chart.update(0);
  });


</script>

<canvas bind:this={ctx} style="position: relative; height:700; width:700" />
