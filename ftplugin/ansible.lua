local api = vim.api
if vim.fn.executable("ansible-doc") then
  vim.bo.keywordprg = ":sp term://ansible-doc"
end
local fname = api.nvim_buf_get_name(0)
local paths = {
  vim.bo.path,
}
if fname:find("tasks/") then
  paths[#paths + 1] = vim.fs.dirname(fname:gsub("tasks/", "files/"))
  paths[#paths + 1] = vim.fs.dirname(fname:gsub("tasks/", "templates/"))
end
if fname:find("roles/") then
  paths[#paths + 1] = vim.fs.dirname(fname:gsub("roles/", "files/"))
  paths[#paths + 1] = vim.fs.dirname(fname:gsub("roles/", "templates/"))
end
if #paths > 1 then
  paths[#paths + 1] = vim.fs.dirname(fname)
  vim.bo.path = table.concat(paths, ",")
else
  paths[#paths + 1] = "foo"
  vim.bo.path = table.concat(paths, ",")
end

vim.bo.suffixesadd = table.concat({
  vim.bo.suffixesadd,
  ".yaml,.yml,.j2,.jinja2",
}, ",")
