let common = [
  'features/**/*.feature',
  '--require-module ts-node/register',
  '--require features/step-definitions/**/*.ts'
].join(' ');

module.exports = {
  default: common,
  // More profiles can be added if desired
};