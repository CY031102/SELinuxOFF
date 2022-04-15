menu(){
    echo "This is a Shell Script to Disable SELinux on CentOS 7"
    echo "這是關閉CentOS7 SELinux的一鍵脚本"
    echo "1. Disable SELinux_關閉SELinux"
    echo "0. Exit_退出脚本"
    read -n2 -p "Please Enter an Option_請輸入選項：" menuChoose
    case ${menuChoose} in
        1) shutselfire ;;
        0) exit 0
    esac
}

shutselfire(){
	check=`sestatus | grep "dis"`
	if [[ $check ]]
	then
		echo "SELinux Disabled_SELinux未启动"
	else
		echo "Detected SELinux enabled, starting disable process"
		echo "檢測SELunix開啓，開始執行關閉"
		echo "Systm will initialize the process in 3 seconds, use Ctrl+C to cancel"
		echo "系統將在3秒后開始關閉SELunix，使用Ctrl+C取消"
		#sleep-for-3-seconds_等待3秒
		sleep 3s
		sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
		sed -i 's/SELINUXTYPE=targeted/#SELINUXTYPE=targeted/g' /etc/selinux/config
		#reboot_重启
		echo "The system will reboot in 5 seconds, press Ctrl+C to cancel"
		echo "系統會在5秒後重新啓動，使用Ctrl+C取消"
		sleep 5s
		reboot
	fi
}

menu
