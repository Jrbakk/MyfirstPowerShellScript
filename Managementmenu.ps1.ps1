do{
Clear-Host
Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Yellow
Write-Host "║" -ForegroundColor Yellow -NoNewline
Write-Host "         Management Menu of Jurre           " -ForegroundColor Green -NoNewline
Write-Host "║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Yellow
Write-Host "Option 1 : Time and Date"
Write-Host "Option 2 : Harddisks Capacitys"
Write-Host "Option 3 : Systeem info"
Write-Host "Option 4 : Gues the number"
Write-Host ""
$optie = Read-Host -Prompt "select your option"

if ($optie -eq 1){
    #code
    Write-Host "Date: $(Get-Date -Format 'dd-MM-yyyy')" -ForegroundColor Cyan
    Write-Host "Time: $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Green
}

elseif ($optie -eq 2){
    #code
    Get-Disk | Sort-Object Size -Descending | ForEach-Object {
        Write-Host "Number: $($_.Number)" -ForegroundColor Magenta
        Write-Host "Name:   $($_.FriendlyName)" -ForegroundColor Green
        Write-Host ("Size:   {0:N2} GB" -f ($_.Size / 1GB)) -ForegroundColor Cyan
        Write-Host ""
    }
}

elseif ($optie -eq 3){
    #code
    $info = Get-ComputerInfo

    Write-Host "=== System Information ===" -ForegroundColor Magenta

    Write-Host -NoNewline "Computer Name:          " -ForegroundColor Green
    Write-Host $info.CsName -ForegroundColor Cyan
    
    Write-Host -NoNewline "Windows Version:        " -ForegroundColor Green
    Write-Host $info.OsName -ForegroundColor Cyan
    
    Write-Host -NoNewline "Architecture:           " -ForegroundColor Green
    Write-Host $info.OsArchitecture -ForegroundColor Cyan
    
    Write-Host -NoNewline "Windows Build:          " -ForegroundColor Green
    Write-Host $info.WindowsVersion -ForegroundColor Cyan
    
    Write-Host -NoNewline "Build Details:          " -ForegroundColor Green
    Write-Host $info.WindowsBuildLabEx -ForegroundColor Cyan
    
    Write-Host -NoNewline "BIOS Version:           " -ForegroundColor Green
    Write-Host $info.BiosVersion -ForegroundColor Cyan
    
    Write-Host -NoNewline "Manufacturer:           " -ForegroundColor Green
    Write-Host $info.CsManufacturer -ForegroundColor Cyan
    
    Write-Host -NoNewline "Model:                  " -ForegroundColor Green
    Write-Host $info.CsModel -ForegroundColor Cyan
    
    Write-Host -NoNewline "Processor:              " -ForegroundColor Green
    Write-Host $info.CsProcessors -ForegroundColor Cyan
    
 # RAM in GB
$ramGB = "{0:N2}" -f ($info.CsTotalPhysicalMemory / 1GB)
Write-Host -NoNewline "RAM Memory:             " -ForegroundColor Green
Write-Host "$ramGB GB" -ForegroundColor Cyan
    
    Write-Host "`n"
}
elseif ($optie -eq 4){
    # Guess the Number Game
    Write-Host "Welcome to Guess the Number Game!" -ForegroundColor Green
    $difficulty = Read-Host "Choose difficulty: Easy, Medium, or Hard"
    switch ($difficulty.ToLower()) {
        "easy" { $max = 10 }
        "medium" { $max = 100 }
        "hard" { $max = 500 }
        default {
            Write-Host "Invalid input. Defaulting to Medium." -ForegroundColor Cyan
            Write-Host "Hint: Please choose Easy, Medium, or Hard." -ForegroundColor DarkYellow
            $max = 100
        }
    }
    $secretNumber = Get-Random -Minimum 1 -Maximum ($max + 1)
    $attempts = 0
    Write-Host "I'm thinking of a number between 1 and $max..."
    Write-Host "Type 'exit' anytime to return to the management menu or 'give up' to reveal the number." -ForegroundColor DarkGray

    while ($true) {
        $input = Read-Host "Enter your guess"

        if ($input -eq "exit") {
            Write-Host "Exiting Guess the Number game..." -ForegroundColor DarkRed
            break
        }

        if ($input -eq "give up") {
            Write-Host "You gave up! The number was $secretNumber." -ForegroundColor Yellow
            break
        }

        if (-not ($input -as [int])) {
            Write-Host "Please enter a valid number, 'exit', or 'give up'." -ForegroundColor Red
            continue
        }

        $guess = [int]$input
        $attempts++

        if ($guess -lt $secretNumber) {
            Write-Host "Too low! Try again." -ForegroundColor Cyan
        } elseif ($guess -gt $secretNumber) {
            Write-Host "Too high! Try again." -ForegroundColor Cyan
        } else {
            Write-Host "🎉 Congratulations! You guessed it in $attempts attempts!" -ForegroundColor Green
            break
        }

        # Provide a hint every 3 attempts, but only in hard mode
        if ($difficulty.ToLower() -eq "hard" -and ($attempts % 3) -eq 0) {
            if ($secretNumber -le ($max / 2)) {
                Write-Host "Hint: The secret number is in the LOWER half of the range." -ForegroundColor DarkYellow
            } else {
                Write-Host "Hint: The secret number is in the UPPER half of the range." -ForegroundColor DarkYellow
            }
        }
    }
}
else {
    Write-Host "Invalid option, please try again." -ForegroundColor Red
}

$keuze = Read-Host "Do you want to choose another option? (y/n)"
} while ($keuze -match '^(y|Y)$')

Write-Host "Program closed, Goodbye 👋🙂" -ForegroundColor DarkMagenta