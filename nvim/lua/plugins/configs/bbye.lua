local present, bbye = pcall(require, "bbye")

if not present then
    return
end

bbye.setup {
}
