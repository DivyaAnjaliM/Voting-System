Below is the **corrected and complete code** for the shell script-based voting system. It includes the ability to vote, view results, and conduct re-elections if necessary. I've fixed indentation issues and ensured the flow of logic is consistent throughout the code.

### Corrected Shell Script Voting System

```sh
#!/bin/sh

bjp=0
congress=0
jds=0
krpp=0
nota=0
total_votes=0

login () {
    echo "LOGIN SUCCESSFUL"
    while true; do
        echo "SELECT YOUR CHOICE:"
        echo "1. CAST VOTE"
        echo "2. CHECK STATUS"
        echo "3. LOGOUT"
        read choice
        case "$choice" in
        1)
            if grep -q "$name" final.lst; then
                echo " YOU HAVE ALREADY VOTED !!"
            else
                echo "$id|$name" >> final.lst
                echo " ***WELCOME TO VOTING SESSION*** "
                echo "***PLEASE VOTE FOR YOUR FAVOURITE PARTY***"
                echo "1. BHARATIYA JANATA PARTY [BJP] "
                echo "2. INDIAN NATIONAL CONGRESS PARTY [CONGRESS] "
                echo "3. JANATA DAL SECULAR [JDS] "
                echo "4. KALYANA RAJYA PRAGATI PAKSHA [KRPP] "
                echo "5. [NOTA] NONE OF THE ABOVE"
                read -p "*VOTE FOR YOUR FAVOURITE PARTY*" ch
                case "$ch" in
                    1) 
                        bjp=$((bjp+1))
                        total_votes=$((total_votes+1))
                        echo "~YOU VOTED FOR BJP~"
                        ;;
                    2)
                        congress=$((congress+1))
                        total_votes=$((total_votes+1))
                        echo "~YOU VOTED FOR CONGRESS~"
                        ;;
                    3)
                        jds=$((jds+1))
                        total_votes=$((total_votes+1))
                        echo "~YOU VOTED FOR JDS~"
                        ;;
                    4)
                        krpp=$((krpp+1))
                        total_votes=$((total_votes+1))
                        echo "~YOU VOTED FOR KRPP~"
                        ;;
                    5)
                        nota=$((nota+1))
                        total_votes=$((total_votes+1))
                        echo "~YOU VOTED FOR NOTA~"
                        ;;
                    *)
                        echo "INVALID CHOICE!!"
                        ;;
                esac
                echo "***THANK YOU FOR VOTING***"
            fi
            ;;
        2)
            echo "~STATUS~"
            echo "*HERE IS THE CURRENT VOTING COUNT*"
            echo "BJP : $bjp votes"
            echo "CONGRESS : $congress votes"
            echo "JDS : $jds votes"
            echo "KRPP : $krpp votes"
            echo "NOTA : $nota votes"
            echo "TOTAL VOTES : $total_votes votes"
            ;;
        3)
            echo "LOGGED OUT....."
            return
            ;;
        *)
            echo "INVALID CHOICE !!"
            ;;
        esac
        read -p "PRESS ENTER TO CONTINUE!!!" a
        clear
    done
}

relection () {
    echo "*** RE-ELECTION ***"
    while true; do
        echo " MAIN MENU "
        echo "1. LOGIN"
        echo "2. DISPLAY RESULTS"
        echo "3. EXIT"
        read op
        case "$op" in
        1)
            echo "ENTER THE VOTER ID"
            read id
            echo "ENTER YOUR NAME AS PER THE ID"
            read name
            grep "$name" voter.lst > check
            checkid=$(cut -d "|" -f 1 check)
            cname=$(cut -d "|" -f 2 check)
            f=0
            if [ "$name" != "$cname" ] || [ "$id" != "$checkid" ]; then
                f=1
            fi
            if [ $f -eq 0 ]; then
                login
                echo "$id|$name" >> final.lst
            else
                echo "***NO MATCHING ID OR NAME !!!***"
            fi
            ;;
        2)
            echo "*HERE IS THE FINAL VOTING COUNT*"
            echo "BJP : $bjp votes"
            echo "CONGRESS : $congress votes"
            echo "JDS : $jds votes"
            echo "KRPP : $krpp votes"
            echo "NOTA : $nota votes"
            echo "TOTAL VOTES : $total_votes votes"
            echo "** FINAL RESULT **"
            a=$bjp
            b=$congress
            c=$jds
            d=$krpp
            if [ $a -gt $b ] && [ $a -gt $c ] && [ $a -gt $d ]; then
                echo "** BJP IS THE WINNER **"
            elif [ $b -gt $a ] && [ $b -gt $c ] && [ $b -gt $d ]; then
                echo "** CONGRESS IS THE WINNER **"
            elif [ $c -gt $a ] && [ $c -gt $b ] && [ $c -gt $d ]; then
                echo "** JDS IS THE WINNER **"
            elif [ $d -gt $a ] && [ $d -gt $b ] && [ $d -gt $c ]; then
                echo "** KRPP IS THE WINNER **"
            else
                echo "** IT'S A DRAW **"
                echo "** NEED TO GO WITH RE-ELECTION **"
                truncate -s 0 final.lst
                relection
            fi
            ;;
        3)
            echo "EXITING....."
            truncate -s 0 final.lst
            exit 0
            ;;
        *)
            echo "INVALID CHOICE !!!"
            ;;
        esac
        echo "PRESS ENTER TO CONTINUE !!!"
        read x
        clear
    done
}

while true; do
    echo " MAIN MENU "
    echo "1. LOGIN"
    echo "2. DISPLAY RESULTS"
    echo "3. EXIT"
    read op
    case "$op" in
    1)
        echo "ENTER THE VOTER ID"
        read id
        echo "ENTER YOUR NAME AS PER THE ID"
        read name
        grep "$name" voter.lst > check
        checkid=$(cut -d "|" -f 1 check)
        cname=$(cut -d "|" -f 2 check)
        f=0
        if [ "$name" != "$cname" ] || [ "$id" != "$checkid" ]; then
            f=1
        fi
        if [ $f -eq 0 ]; then
            login
            echo "$id|$name" >> final.lst
        else
            echo "***NO MATCHING ID OR NAME !!!***"
        fi
        ;;
    2)
        echo "*HERE IS THE FINAL VOTING COUNT*"
        echo "BJP : $bjp votes"
        echo "CONGRESS : $congress votes"
        echo "JDS : $jds votes"
        echo "KRPP : $krpp votes"
        echo "NOTA : $nota votes"
        echo "TOTAL VOTES : $total_votes votes"
        echo "** FINAL RESULT **"
        a=$bjp
        b=$congress
        c=$jds
        d=$krpp
        if [ $a -gt $b ] && [ $a -gt $c ] && [ $a -gt $d ]; then
            echo "** BJP IS THE WINNER **"
        elif [ $b -gt $a ] && [ $b -gt $c ] && [ $b -gt $d ]; then
            echo "** CONGRESS IS THE WINNER **"
        elif [ $c -gt $a ] && [ $c -gt $b ] && [ $c -gt $d ]; then
            echo "** JDS IS THE WINNER **"
        elif [ $d -gt $a ] && [ $d -gt $b ] && [ $d -gt $c ]; then
            echo "** KRPP IS THE WINNER **"
        else
            echo "** IT'S A DRAW **"
            echo "** NEED TO GO WITH RE-ELECTION **"
            truncate -s 0 final.lst
            relection
        fi
        ;;
    3)
        echo "EXITING....."
        truncate -s 0 final.lst
        exit 0
        ;;
    *)
        echo "INVALID CHOICE !!!"
        ;;
    esac
    echo "PRESS ENTER TO CONTINUE !!!"
    read x
    clear
done
```

### Key Features of the Script:
1. **Login System**: Validates the voter's ID and name from the `voter.lst` file.
2. **Voting System**: Allows a voter to vote for their favorite party and updates the vote count.
3. **Result Display**: Shows the current status of votes.
4. **Re-election Mechanism**: Automatically initiates re-election in case of a tie.
5. **File Handling**: Stores the IDs and names of voters in `final.lst` to prevent duplicate voting.
6. **Vote Summary**: Displays the voting results and identifies the winner or initiates a re-election if needed.

This script can be run in a shell environment. Make sure to have the `voter.lst` file in the same directory, containing voter details in the format `id

|name`.