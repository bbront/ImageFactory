#Cleanup Validate VMs
Update-Log -Data "Cleanup Validate VMs"
Invoke-Command -ComputerName $($Settings.Settings.HyperV.Computername) -ScriptBlock {
    $ValVMs = Get-VM | Where-Object -Property Notes -Like -Value "VALIDATE*" 
    Foreach($ValVM in $ValVMs){
        $VM = Get-VM -VMName $ValVM.Name
        Write-Verbose "Deleting $($VM.Name) on $($VM.Computername) at $($VM.ConfigurationLocation)"
        Remove-VM -VM $VM -Force
        Remove-Item -Path $VM.ConfigurationLocation -Recurse -Force
    }
}

#Cleanup Reference VMs
Update-Log -Data "Cleanup Reference VMs"
Invoke-Command -ComputerName $($Settings.Settings.HyperV.Computername) -ScriptBlock {
    $ValVMs = Get-VM | Where-Object -Property Notes -Like -Value "REFIMAGE*" 
    Foreach($ValVM in $ValVMs){
        $VM = Get-VM -VMName $ValVM.Name
        Write-Verbose "Deleting $($VM.Name) on $($VM.Computername) at $($VM.ConfigurationLocation)"
        Remove-VM -VM $VM -Force
        Remove-Item -Path $VM.ConfigurationLocation -Recurse -Force
    }
}