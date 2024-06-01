module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: [
    'eslint:recommended',
    'plugin:vue/vue3-essential', // or 'plugin:vue/vue3-strongly-recommended' or 'plugin:vue/vue3-recommended'
  ],
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module',
  },
  plugins: [
    'vue',
  ],
  rules: {
    // Define your project's rules here
    'vue/no-unused-vars': 'error',
    // other rules...
  },
};
