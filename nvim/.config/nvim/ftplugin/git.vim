command! -bang -range BranchDelete call my#ft#git#deleteBranch(<bang>0,<line1>,<line2>)
