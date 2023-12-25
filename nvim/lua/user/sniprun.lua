local status_ok, sniprun = pcall(require, "sniprun")
if not status_ok then
    return
end

sniprun.setup({
    selected_interpreters={"JS_TS_deno", "Python3_original", "OrgMode_original"},
    repl_enable = {"JS_TS_deno", "Python3_original"},
    display = {
        "ClassicErr",
        "LongTempFloatingWindow",
        "VirtualText",
    },
})

