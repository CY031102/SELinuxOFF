menu(){
    echo "This is a Shell Script to Disable SELinux & firewalld on CentOS 7"
    echo "這是關閉CentOS7 SELinux & firewalld 的一鍵脚本"
    echo "1. Disable SELinux & firewalld"
	echo "   關閉SELinux & Firewalld"
	echo "2. Disable SELinux Only"
	echo "   僅關閉SElinux"
	echo "3. Disable firewalld Only"
	echo "   僅關閉firewalld"
    echo "0. Exit"
	echo "   退出脚本"
    read -n2 -p "Please Enter an Option_請輸入選項：" menuChoose
    case ${menuChoose} in
        1) shutselfire ;;
		2) shutsel ;;
		3) shutfire ;;
        0) exit 0
    esac
}

shutselfire(){
	check_two=`systemctl status firewalld | grep "dead"`
	if [[ $check_two ]]
	then
		echo "firewalld is inactive"
		echo "firewalld 已關閉或未啓動"
	else
		echo "Detected firewalld is running/dead/not installed, will initialize firewalld shutdown"
		echo "檢測firewalld可能在運行中/不存在，開始執行關閉"
		echo "System will initialize the process in 3 seconds, use Ctrl+C to cancel"
		echo "系統將在3秒后開始關閉firewalld，使用Ctrl+C取消"
		#sleep-for-3-seconds_等待3秒
		sleep 3s
		systemctl stop firewalld.service
		systemctl disable firewalld.service
	fi
	
	check=`sestatus | grep "dis"`
	if [[ $check ]]
	then
		echo "SELinux Disabled"
		echo "SELinux 已禁用"
	else
		echo "Detected SELinux enabled, starting disable process"
		echo "檢測SELunix已啓用，開始執行關閉"
		echo "Systm will initialize the process in 3 seconds, use Ctrl+C to cancel"
		echo "系統將在3秒后開始關閉SELunix，使用Ctrl+C取消"
		#sleep-for-3-seconds_等待3秒
		sleep 3s
		sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
		sed -i 's/SELINUXTYPE=targeted/#SELINUXTYPE=targeted/g' /etc/selinux/config
		#reboot_重新啓動
		echo "A reboot is requiered to Completely disable SELinux, the process will initiate in 5 seconds, use Ctrl+C to cancel"
		echo "由於完整關閉SELinux需要重新啓動，系統會在5秒後重啓，使用Ctrl+C取消"
		sleep 5s
		reboot
	fi
	
}	

shutsel(){
	check=`sestatus | grep "dis"`
	if [[ $check ]]
	then
		echo "SELinux Disabled"
		echo "SELinux 已禁用"
	else
		echo "Detected SELinux enabled, starting disable process"
		echo "檢測SELunix已啓用，開始執行關閉"
		echo "Systm will initialize the process in 3 seconds, use Ctrl+C to cancel"
		echo "系統將在3秒后開始關閉SELunix，使用Ctrl+C取消"
		#sleep-for-3-seconds_等待3秒
		sleep 3s
		sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
		sed -i 's/SELINUXTYPE=targeted/#SELINUXTYPE=targeted/g' /etc/selinux/config
		#reboot_重新啓動
		echo "A reboot is requiered to Completely disable SELinux, the process will initiate in 5 seconds, use Ctrl+C to cancel"
		echo "由於完整關閉SELinux需要重新啓動，系統會在5秒後重啓，使用Ctrl+C取消"
		sleep 5s
		reboot
	fi
	
}	

shutfire(){
	check_two=`systemctl status firewalld | grep "dead"`
	if [[ $check_two ]]
	then
		echo "firewalld is inactive"
		echo "firewalld 已關閉或未啓動"
	else
		echo "Detected firewalld is running/dead/not installed, will initialize firewalld shutdown"
		echo "檢測firewalld可能在運行中/不存在，開始執行關閉"
		echo "System will initialize the process in 3 seconds, use Ctrl+C to cancel"
		echo "系統將在3秒后開始關閉firewalld，使用Ctrl+C取消"
		#sleep-for-3-seconds_等待3秒
		sleep 3s
		systemctl stop firewalld.service
		systemctl disable firewalld.service
	fi

}

menu
