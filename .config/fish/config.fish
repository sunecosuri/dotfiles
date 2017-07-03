set fish_plugins theme peco
#peco
function fish_user_key_bindings
    bind \cr peco_select_history
    bind \cf peco_change_directory
end


function gvm
  bass source ~/.gvm/scripts/gvm ';' gvm $argv
end
