local _0_0 = nil
do
  local name_23_0_ = "aniseed.compile"
  local loaded_23_0_ = package.loaded[name_23_0_]
  local module_23_0_ = nil
  if ("table" == type(loaded_23_0_)) then
    module_23_0_ = loaded_23_0_
  else
    module_23_0_ = {}
  end
  module_23_0_["aniseed/module"] = name_23_0_
  module_23_0_["aniseed/locals"] = (module_23_0_["aniseed/locals"] or {})
  module_23_0_["aniseed/local-fns"] = (module_23_0_["aniseed/local-fns"] or {})
  package.loaded[name_23_0_] = module_23_0_
  _0_0 = module_23_0_
end
local function _1_(...)
  _0_0["aniseed/local-fns"] = {require = {a = "aniseed.core", fennel = "aniseed.fennel", fs = "aniseed.fs", nvim = "aniseed.nvim"}}
  return {require("aniseed.core"), require("aniseed.fennel"), require("aniseed.fs"), require("aniseed.nvim")}
end
local _2_ = _1_(...)
local a = _2_[1]
local fennel = _2_[2]
local fs = _2_[3]
local nvim = _2_[4]
do local _ = ({nil, _0_0, {{}, nil}})[2] end
do
  local fnl_suffixes = string.gsub(string.gsub(package.path, "%.lua;", ".fnl;"), "%.lua$", ".fnl")
  fennel.path = (string.gsub(fnl_suffixes, "/lua/", "/fnl/") .. ";" .. fnl_suffixes)
end
local macros_prefix = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function macros_prefix0(code)
      local macros_module = "aniseed.macros"
      return ("(require-macros \"" .. macros_module .. "\")\n" .. code)
    end
    v_23_0_0 = macros_prefix0
    _0_0["macros-prefix"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["macros-prefix"] = v_23_0_
  macros_prefix = v_23_0_
end
local str = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function str0(code, opts)
      local function _3_()
        return fennel.compileString(macros_prefix(code), opts)
      end
      return xpcall(_3_, fennel.traceback)
    end
    v_23_0_0 = str0
    _0_0["str"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["str"] = v_23_0_
  str = v_23_0_
end
local file = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function file0(src, dest, opts)
      if ((a["table?"](opts) and opts.force) or (nvim.fn.getftime(src) > nvim.fn.getftime(dest))) then
        local code = a.slurp(src)
        local _3_0, _4_0 = str(code, {filename = src})
        if ((_3_0 == false) and (nil ~= _4_0)) then
          local err = _4_0
          return nvim.err_writeln(err)
        elseif ((_3_0 == true) and (nil ~= _4_0)) then
          local result = _4_0
          fs.mkdirp(fs.basename(dest))
          return a.spit(dest, result)
        end
      end
    end
    v_23_0_0 = file0
    _0_0["file"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["file"] = v_23_0_
  file = v_23_0_
end
local glob = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function glob0(src_expr, src_dir, dest_dir, opts)
      local src_dir_len = a.inc(string.len(src_dir))
      local src_paths = nil
      local function _3_(path)
        return string.sub(path, src_dir_len)
      end
      src_paths = a.map(_3_, nvim.fn.globpath(src_dir, src_expr, true, true))
      for _, path in ipairs(src_paths) do
        file((src_dir .. path), string.gsub((dest_dir .. path), ".fnl$", ".lua"), opts)
      end
      return nil
    end
    v_23_0_0 = glob0
    _0_0["glob"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["glob"] = v_23_0_
  glob = v_23_0_
end
return nil
