module.exports = {
  purge: ['./src/**/*.svelte'],
  theme: {
    extend: {},
  },
  variants: {
    backgroundColor: ['responsive', 'hover', 'focus', 'active'],
    cursor: ['responsive', 'disabled'],
    opacity: ['responsive', 'hover', 'focus', 'disabled'],
  },
  plugins: [],
};
