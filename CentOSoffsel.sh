[[ $EUID -ne 0 ]] && echo "请在root用户下运行脚本" && exit 1

menu(){
    clear
    getStatus
    echo ""
    echo "1. 关闭SELinux+禁用防火墙"
    echo "2. 禁用防火墙"
    echo "0. 退出脚本"
    read -n2 -p "请输入选项：" menuChoose
    case ${menuChoose} in
        1) shutselfire ;;
        2) shutfire ;;
        0) exit 0
    esac
}

shutselfire(){
    if [[ -n $(which cloudflared 2> /dev/null) ]]; then
        echo "检测SELunix开启，开始执行关闭"
    else
        getArch=$(uname -m) #检查系统架构
        echo "【开始安装】系统架构为 ${getArch}"
# 关闭SELiunx
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sed -i 's/SELINUXTYPE=targeted/#SELINUXTYPE=targeted/g' /etc/selinux/config


}
#重启
  fi

  stty erase '^H' && read -p "需要重启VPS后，才能开启BBR，是否现在重启 ? [Y/n] :" yn
  [ -z "${yn}" ] && yn="y"
  if [[ $yn == [Yy] ]]; then
    echo -e "${Info} VPS 重启中..."
    reboot
  else
    echo -e "${Info} 设置完成，请记得手动重启伺服器"
  fi
  
}
