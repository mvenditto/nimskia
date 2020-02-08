param (
	[Parameter(Mandatory=$true)][string]$src
)

$lib_path = join-path -path (get-item $PSScriptRoot).parent.FullName -childpath "libs"
if (-not($env:Path.Contains($lib_path))) {
	$semicolonOrNot = if($env:Path[-1] -eq ";") {''} else {';'}
	$env:Path += -join($semicolonOrNot, $lib_path)
}

$out = ".\bin\${src}.exe"
nim c -o:$out $src
invoke-expression $out
