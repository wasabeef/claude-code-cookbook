/** @type {import('@commitlint/types').UserConfig} */
module.exports = {
  extends: ["@commitlint/config-conventional"],
  rules: {
    // Align with git-cliff commit_parsers in .github/cliff.toml
    "type-enum": [
      2,
      "always",
      [
        "feat",
        "fix",
        "perf",
        "refactor",
        "style",
        "test",
        "chore",
        "docs",
        "ci",
        "build",
        "add",
        "remove",
        "delete",
        "support",
        "revert",
      ],
    ],
    "subject-case": [0],
    "body-max-line-length": [0],
  },
};
