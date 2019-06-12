
function! ExistInCurrentOrParentFolder(filename)
  let l:found = 0

  let l:currentPath = getcwd()
  let l:fullFilePath = l:currentPath . '/' . a:filename

  while l:found == 0
    if filereadable(l:fullFilePath) 
      let l:found = 1
      break
    endif
    let l:parentPath = fnamemodify(l:currentPath, ':h') 
    echo l:parentPath
    if !isdirectory(l:parentPath) || l:parentPath == l:currentPath 
      " parent equals current means no further parent, must be "/"
      break
    endif
    let l:fullFilePath = l:parentPath . '/' . a:filename
    let l:currentPath = l:parentPath
  endwhile
  return l:found
endfunc





