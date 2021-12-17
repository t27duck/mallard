const rails = require('esbuild-rails')

const watch = process.argv.includes("--watch") && {
  onRebuild(error) {
    if (error) console.error("[watch] build failed", error);
    else console.log("[watch] build finished");
  },
};

 require("esbuild").build({
  entryPoints: ["app/javascript/application.js"],
  bundle: true,
  outdir: "app/assets/builds",
  watch: watch,
  sourcemap: true,
  plugins: [
    rails()
  ],
}).catch(() => process.exit(1));
