#!/usr/bin/env bash
DIR=$(pwd)
# Function to display a progress bar
progress_bar() {
    local PROG_BAR='####################'
    local BLANK_BAR='                    '
    local PROGRESS=$1
    printf "\r[%.*s%.*s] %d%%" $PROGRESS "$PROG_BAR" $((20-PROGRESS)) "$BLANK_BAR" $((PROGRESS*5))
}

# Function to find a library
find_library() {
    SEARCH=$1
    LIBRARY=$(ldconfig -p | grep -F $SEARCH -m 1 | awk '{print $1}')
    if [ -z "$LIBRARY" ]; then
        return 1
    fi
    printf '%s' "$LIBRARY"
}

ROOT=''
echo "Checking for superuser privileges..."
if [ "$(whoami)" != "root" ]; then
    if ! command -v sudo 2>&1 >/dev/null; then
        echo "Not running as root and sudo is not available."
        exit 1
    fi
    if ! sudo -v; then
        echo "Failed to acquire superuser privileges."
        exit 1
    fi
    ROOT='sudo'
fi

# Refresh system library cache
$ROOT ldconfig

declare -a PACKAGES_DEBIAN=(
    'git'
    'cmake'
    'ninja-build'
    'clang'
    'systemtap-sdt-dev'
    'libbsd-dev'
    'linux-libc-dev'
    'curl'
    'tar'
    'grep'
    'mawk'
    'patchelf'
    '^libgnustep-base1\.[0-9]*$'
    'libobjc4'
    '^libgnutls[0-9]*$'
    '^libgcrypt[0-9]*$'
    'libxml2'
    '^libffi[0-9]*$'
    '^libnsl[0-9]*$'
    'zlib1g'
    '^libicu[0-9]*$'
    'libicu-dev'
    'libstdc++6'
    'libgcc-s1'
)

build_libdispatch() {
    if [ -d "${DIR}/swift-corelibs-libdispatch/build" ]; then
        rm -rf 'swift-corelibs-libdispatch'        
    fi
    git clone --depth 1 'https://github.com/swiftlang/swift-corelibs-libdispatch.git' "${DIR}/swift-corelibs-libdispatch" || exit 1
    mkdir -p "${DIR}/swift-corelibs-libdispatch/build" || exit 1
    cd "${DIR}/swift-corelibs-libdispatch/build" || exit 1
    cmake -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ .. || exit 1
    ninja "-j$(nproc)" || exit 1
    $ROOT ninja install || exit 1
    cd "${DIR}" || exit 1
    # Refresh system library cache
    $ROOT ldconfig
}

install_packages_debian() {
    echo "Installing packages for Ubuntu..."
    $ROOT apt-get update || exit 1
    $ROOT apt-get install -y "${PACKAGES_DEBIAN[@]}" || exit 1
    if ! find_library 'libdispatch.so'; then
        echo "libdispatch.so not found, building libdispatch..."
        build_libdispatch
    fi
}

install_packages() {
    install_packages_debian
}

install_packages

# Download the file with progress bar
echo "Downloading blockheads_server171.tar.gz..."

curl -#L https://majicdave.com/share/blockheads_server171.tar.gz --insecure -o blockheads_server171.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to download from majicdave.com, trying archive.org..."
    curl -#L https://archive.org/download/BHSv171/blockheads_server171.tar.gz -o blockheads_server171.tar.gz
    if [ $? -ne 0 ]; then
        echo "Failed to download from both sources."
        exit 1
    fi
fi

# Extract the file
echo "Extracting blockheads_server171.tar.gz..."
tar xzvf blockheads_server171.tar.gz
chmod +x blockheads_server171

# Unlink tarball
rm -v blockheads_server171.tar.gz

# Define variables
FILE="blockheads_server171"
declare -A LIBS=(
    ["libgnustep-base.so.1.24"]="$(find_library 'libgnustep-base.so')"
    ["libobjc.so.4.6"]="$(find_library 'libobjc.so')"
    ["libgnutls.so.26"]="$(find_library 'libgnutls.so')"
    ["libgcrypt.so.11"]="$(find_library 'libgcrypt.so')"
    ["libxml2.so.2"]="$(find_library 'libxml2.so')"
    ["libffi.so.6"]="$(find_library 'libffi.so')"
    ["libnsl.so.1"]="$(find_library 'libnsl.so')"
    ["librt.so.1"]="$(find_library 'librt.so')"
    ["libdl.so.2"]="$(find_library 'libdl.so')"
    ["libpthread.so.0"]="$(find_library 'libpthread.so')"
    ["libz.so.1"]="$(find_library 'libz.so')"
    ["libicui18n.so.48"]="$(find_library 'libicui18n.so')"
    ["libicuuc.so.48"]="$(find_library 'libicuuc.so')"
    ["libicudata.so.48"]="$(find_library 'libicudata.so')"
    ["libdispatch.so"]="$(find_library 'libdispatch.so')"
    ["libm.so.6"]="$(find_library 'libm.so')"
    ["libstdc++.so.6"]="$(find_library 'libstdc++.so')"
    ["libgcc_s.so.1"]="$(find_library 'libgcc_s.so')"
    ["libc.so.6"]="$(find_library 'libc.so')"
)

# Replace needed libraries with progress feedback
TOTAL_LIBS=${#LIBS[@]}
COUNT=0

for LIB in "${!LIBS[@]}"; do
    if [ -z "${LIBS[$LIB]}" ]; then
        echo "Failed to locate up-to-date matching library for $LIB"
        exit 1
    fi
    COUNT=$((COUNT+1))
    PERCENTAGE=$((COUNT * 100 / TOTAL_LIBS / 5))
    echo -n "Patching $LIB -> ${LIBS[$LIB]} "
    progress_bar $PERCENTAGE
    patchelf --replace-needed $LIB ${LIBS[$LIB]} $FILE || { echo "Failed to patch the BHS for $LIB"; exit 1; }
done

echo -e "\nThe BHS has been patched successfully!"

# Prompt the user for the Blockheads World name with default "New World"
read -p "Enter the name of your Blockheads World [New World]: " WORLD_NAME
WORLD_NAME=${WORLD_NAME:-"New World"}

# Prompt the user for the server port with default 15151
read -p "Enter the port for your Blockheads server [15151]: " SERVER_PORT
SERVER_PORT=${SERVER_PORT:-15151}

# Check if the port is within the valid range
if ! [[ "$SERVER_PORT" =~ ^[0-9]+$ ]] || [ "$SERVER_PORT" -lt 1 ] || [ "$SERVER_PORT" -gt 65535 ]; then
    echo "Invalid port number. Please enter a port between 1 and 65535."
    exit 1
fi

# Create run.sh with the specified content
cat <<EOF > run.sh
#!/bin/bash
world_id="83cad395edb8d0f1912fec89508d8a1d"
server_port=$SERVER_PORT

# Function to safely shut down the server
function shutdown {
    echo "Shutting down the server..." | tee -a bhs-server-log.txt
    pkill -SIGINT -f './blockheads_server171 -o' # Command to stop the server
    exit 0
}

# Trap to handle script termination and execute the shutdown function
trap shutdown SIGTERM SIGINT

while true; do
    ./blockheads_server171 --no-exit -o "\$world_id" -p "\$server_port" 2>&1 | tee -a bhs-server-log.txt
    echo "Server restarted at \$(date)" | tee -a bhs-server-log.txt
    sleep 1
done
EOF

# Make run.sh executable
chmod +x run.sh

echo -e "\nThe run.sh script has been created and made executable."

# Prompt the user if they want to start the server
read -p "Do you want to start the Blockheads server now? (y/n): " START_SERVER

if [ "$START_SERVER" == "y" ]; then
    IP_ADDRESS=$(hostname -I | awk '{print $1}')
    CONTAINER_ID=$(hostname)
    echo "Starting the Blockheads server..."
    ./run.sh &

    echo -e "\nYour Blockheads server is now running!"
    echo "Access it at: $IP_ADDRESS:$SERVER_PORT"
    echo "To stop the server: Press Ctrl+C or use 'docker stop $CONTAINER_ID'"
    echo "To start the server again: Run 'docker start $CONTAINER_ID' within the Docker container"
else
    echo "You can start the Blockheads server later by running 'docker start <container-id>' within the Docker container."
