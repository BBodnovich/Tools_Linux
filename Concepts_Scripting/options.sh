# Usage
while getopts u:p:ab option; do
	case $option in
		u) user=$OPTARG;;
		p) pass=$OPTARG;;
		a) echo "Got the A flag";;
		b) echo "Got the B flag";;
	esac
done
echo "User: $user / Pass: $pass"


# Options Syntax
# u:              Only -u requires argument
# u:p             Only -u requires argument, -p does not require argument
# u:p:            Both -u and -p require arguments
# u:p:ab          Both -u and -p require arguments, -a and -b do not