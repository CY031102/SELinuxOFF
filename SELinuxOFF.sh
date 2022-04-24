menu(){
    echo "This is a Shell Script to Disable SELinux & firewalld on CentOS 7"
    echo "這是關閉CentOS7 SELinux & firewalld 的一鍵脚本"
	echo "v1.2.5"
    echo "1. Disable SELinux & firewalld"
	echo "   關閉SELinux & firewalld"
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
	check_two=`systemctl status firewalld | grep "running"`
	check_three=`systemctl status firewalld | grep "dead"`
	echo 'If command line responds as' '"Unit firewalld.service could not be found."'" It means that you did not install firewalld"
	echo "(You can ignore the error)"
	echo '若命令行反饋' '"Unit firewalld.service could not be found."'" 代表你沒有安裝firewalld"
	echo "（無視報錯即可）"
	if [[ $check_two ]];then
		if [[ $check_three -ne dead ]];then
			echo "Detected firewalld is running, will initiate firewalld shutdown & disable"
			echo "檢測firewalld在運行中，開始執行關閉 & 禁用"
			echo "System will initiate the process in 3 seconds, use Ctrl+C to cancel"
			echo "系統將在3秒后開始關閉 & 禁用firewalld，使用Ctrl+C取消"
			#sleep-for-3-seconds_等待3秒
			sleep 3s
			systemctl stop firewalld.service
			systemctl disable firewalld.service
				if [[ $check_three ]];then
					echo "firewalld is now disabled & Will not start on next boot"
					echo "firewalld 現在已禁用 & 重啓後將不會自啓"
				fi
		fi
	else		
		if [[ $check_three ]]
		then
			echo "Detected firewalld is dead, will disable firewalld auto start on boot"
			echo "檢測firewalld在已關閉，開始禁用開機自啓動"
			echo "System will initiate the process in 3 seconds, use Ctrl+C to cancel"
			echo "系統將在3秒后開始禁用firewalld開機自啓，使用Ctrl+C取消"
			#sleep-for-3-seconds_等待3秒
			sleep 3s
			systemctl disable firewalld.service
			echo "firewalld will not start on next boot"
			echo "firewalld 將不會在重啓後自啓"	
		fi
	fi
	

	
	check=`getenforce | grep "Dis"`
	if [[ $check ]]
	then
		echo "SELinux is Disabled by default"
		echo "SELinux 默認未啓用"
	else
		echo "Detected SELinux Enabled, starting Disable process"
		echo "檢測SELunix已啓用，開始執行關閉"
		echo "Systm will initiate the process in 3 seconds, use Ctrl+C to cancel"
		echo "系統將在3秒后開始關閉SELunix，使用Ctrl+C取消"
		#sleep-for-3-seconds_等待3秒
		sleep 3s
		sed -i '1,$d' /etc/selinux/config
		cat > /etc/selinux/config <<EOL
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of these two values:
#       targeted - Targeted processes are protected,
#       mls - Multi Level Security protection.
#SELINUXTYPE=targeted
EOL
	
		#reboot_重新啓動
		echo "A reboot is required to completely disable SELinux, the process will initiate in 5 seconds, use Ctrl+C to cancel"
		echo "由於完整關閉SELinux需要重新啓動，系統會在5秒後重啓，使用Ctrl+C取消"
		sleep 5s
		reboot
	fi
	
}	

shutsel(){
	check=`getenforce | grep "Dis"`
	if [[ $check ]]
	then
		echo "SELinux is Disabled by default"
		echo "SELinux 默認未啓用"
	else
		echo "Detected SELinux Enabled, starting Disable process"
		echo "檢測SELunix已啓用，開始執行關閉"
		echo "System will initiate the process in 3 seconds, use Ctrl+C to cancel"
		echo "系統將在3秒后開始關閉SELunix，使用Ctrl+C取消"
		#sleep-for-3-seconds_等待3秒
		sleep 3s
		sed -i '1,$d' /etc/selinux/config
		cat > /etc/selinux/config <<EOL
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of these two values:
#       targeted - Targeted processes are protected,
#       mls - Multi Level Security protection.
#SELINUXTYPE=targeted
EOL
		#reboot_重新啓動
		echo "A reboot is required to completely disable SELinux, the process will initiate in 5 seconds, use Ctrl+C to cancel"
		echo "由於完整關閉SELinux需要重新啓動，系統會在5秒後重啓，使用Ctrl+C取消"
		sleep 5s
		reboot
	fi
	
}	

shutfire(){
	check_two=`systemctl status firewalld | grep "running"`
	check_three=`systemctl status firewalld | grep "dead"`
	echo 'If command line responds as' '"Unit firewalld.service could not be found."'" It means that you did not install firewalld"
	echo "(You can ignore the error)"
	echo '若命令行反饋' '"Unit firewalld.service could not be found."'" 代表你沒有安裝firewalld"
	echo "（無視報錯即可）"
	if [[ $check_two ]];then
		if [[ $check_three -ne dead ]];then
			echo "Detected firewalld is running, will initiate firewalld shutdown & disable"
			echo "檢測firewalld在運行中，開始執行關閉 & 禁用"
			echo "System will initiate the process in 3 seconds, use Ctrl+C to cancel"
			echo "系統將在3秒后開始關閉 & 禁用firewalld，使用Ctrl+C取消"
			#sleep-for-3-seconds_等待3秒
			sleep 3s
			systemctl stop firewalld.service
			systemctl disable firewalld.service
				if [[ $check_three ]];then
					echo "firewalld is now disabled & Will not start on next boot"
					echo "firewalld 現在已禁用 & 重啓後將不會自啓"
				fi
		fi
	else		
		if [[ $check_three ]]
		then
			echo "Detected firewalld is dead, will disable firewalld auto start on boot"
			echo "檢測firewalld在已關閉，開始禁用開機自啓動"
			echo "System will initiate the process in 3 seconds, use Ctrl+C to cancel"
			echo "系統將在3秒后開始禁用firewalld開機自啓，使用Ctrl+C取消"
			#sleep-for-3-seconds_等待3秒
			sleep 3s
			systemctl disable firewalld.service
			echo "firewalld will not start on next boot"
			echo "firewalld 將不會在重啓後自啓"	
		fi
	fi
	
}


menu
