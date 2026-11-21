" Obsidian equivalents for the Neovim mappings in ~/nvim.
set clipboard=unnamedplus
unmap <Space>
nmap <Space>h :nohl<CR>

exmap savenote obcommand editor:save-file
nmap <Space>w :savenote<CR>
exmap closetab obcommand workspace:close
nmap <Space>q :closetab<CR>
nmap <Space>bc :closetab<CR>
exmap filetree obcommand app:toggle-left-sidebar
nmap <Space>e :filetree<CR>
exmap findnote obcommand switcher:open
nmap <Space>ff :findnote<CR>
nmap <Space><Space> :findnote<CR>
exmap vaultsearch obcommand global-search:open
nmap <Space>fg :vaultsearch<CR>
exmap noteoutline obcommand outline:open
nmap <Space>fs :noteoutline<CR>
exmap followlink obcommand editor:follow-link
nmap <Space>gd :followlink<CR>
exmap notebacklinks obcommand backlink:open
nmap <Space>gr :notebacklinks<CR>
exmap notereplace obcommand editor:open-search-replace
nmap <Space>sr :notereplace<CR>
exmap markdownview obcommand editor:toggle-source
nmap <Space>md :markdownview<CR>
exmap gitdiff obcommand obsidian-git:open-diff-view
nmap <Space>gp :gitdiff<CR>
nmap <C-n> :filetree<CR>

exmap prevtab obcommand workspace:previous-tab
nmap H :prevtab<CR>
exmap nexttab obcommand workspace:next-tab
nmap L :nexttab<CR>
exmap gototab1 obcommand workspace:goto-tab-1
nmap <Space>1 :gototab1<CR>
exmap gototab2 obcommand workspace:goto-tab-2
nmap <Space>2 :gototab2<CR>
exmap gototab3 obcommand workspace:goto-tab-3
nmap <Space>3 :gototab3<CR>
exmap gototab4 obcommand workspace:goto-tab-4
nmap <Space>4 :gototab4<CR>
exmap gototab5 obcommand workspace:goto-tab-5
nmap <Space>5 :gototab5<CR>

exmap revealnote obcommand file-explorer:reveal-active-file
nmap - :revealnote<CR>

exmap focusleft obcommand editor:focus-left
nmap <C-h> :focusleft<CR>
nmap <A-h> :focusleft<CR>
exmap focusbottom obcommand editor:focus-bottom
nmap <C-j> :focusbottom<CR>
nmap <A-j> :focusbottom<CR>
exmap focustop obcommand editor:focus-top
nmap <C-k> :focustop<CR>
nmap <A-k> :focustop<CR>
exmap focusright obcommand editor:focus-right
nmap <C-l> :focusright<CR>
nmap <A-l> :focusright<CR>

vnoremap < <gv
vnoremap > >gv
exmap movelinedown obcommand editor:swap-line-down
exmap movelineup obcommand editor:swap-line-up
vmap J :movelinedown<CR>
vmap K :movelineup<CR>
