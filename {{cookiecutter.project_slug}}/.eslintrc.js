module.exports = {
  extends: [
    "airbnb-base",
    "plugin:prettier/recommended",
    "plugin:jest/recommended",
    "plugin:jest-formatting/recommended",
    "plugin:jest/style",
  ],
  plugins: ["prettier", "jest-formatting", "jest"],
  rules: {
    "max-len": "off",
    "no-underscore-dangle": 0,
    "no-unused-vars": ["error", { argsIgnorePattern: "next" }],
    camelcase: 0,
  },
  env: {
    jest: true,
  },
};
