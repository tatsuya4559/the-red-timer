import App from './App.svelte';
// import Header from './UI/Header.svelte'

const app = new App({
  target: document.getElementById('app')
});

// マウントポイントを複数作ることもできる
// const header = new Header({
//   target: document.getElementById('header')
// })

export default app;
