
$7Zexe = "$env:ProgramFiles\7-Zip\7zFM.exe"
if(Test-Path $7Zexe){
	'7z','xz','bzip2','gzip','tar','zip','wim','apfs','ar','arj','cab','chm','cpio','cramfs','dmg','ext','fat','gpt','hfs','ihex','iso','lzh','lzma','mbr','msi','nsis','ntfs','qcow2','rar','rpm','squashfs','udf','uefi','vdi','vhd','vhdx','vmdk','xar','z'|%{
		cmd /c "assoc .$_=7zFM.exe" >$null
		}
	cmd /c 'ftype 7zFM.exe="C:\Program Files\7-Zip\7zFM.exe" "%1" "%*"' >$null
}					
