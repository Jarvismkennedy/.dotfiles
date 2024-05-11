function install_dotnet_version
    set --local v $argv[1]
    echo "Installing .NET Core version $v..."
    curl --silent --show-error --location https://dot.net/v1/dotnet-install.sh \
        | sudo bash /dev/stdin -c "$v" --install-dir /usr/share/dotnet
end

