#!/bin/bash

# 颜色定义
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# 工作目录
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# 进程管理文件
PID_FILE=".sd_webui.pid"
PORT_FILE=".sd_webui.port"

# 镜像源配置
PYPI_MIRROR="https://pypi.tuna.tsinghua.edu.cn/simple"
PYPI_MIRROR_BAK="https://mirrors.aliyun.com/pypi/simple"

# 兼容的依赖包配置（针对Apple Silicon优化）
COMPATIBLE_PACKAGES=(
"absl-py==2.3.1"
"accelerate==0.21.0"
"addict==2.4.0"
"aenum==3.1.11"
"aiofiles==23.2.1"
"aiohappyeyeballs==2.6.1"
"aiohttp==3.13.2"
"aiosignal==1.4.0"
"altair==5.5.0"
"annotated-doc==0.0.3"
"annotated-types==0.7.0"
"antlr4-python3-runtime==4.9.3"
"anyio==4.11.0"
"async-timeout==5.0.1"
"attrs==25.4.0"
"basicsr==1.4.2"
"beautifulsoup4==4.14.2"
"blendmodes==2022"
"brotli==1.2.0"
"certifi==2025.10.5"
"charset-normalizer==3.4.4"
"clean-fid==0.1.35"
"click==8.3.0"
"cloudpickle==2.2.1"
"contourpy==1.3.2"
"cycler==0.12.1"
"decorator==5.1.1"
"deprecation==2.1.0"
"diffusers==0.35.2"
"diskcache==5.6.3"
"einops==0.4.1"
"exceptiongroup==1.3.0"
"facexlib==0.3.0"
"fairscale==0.4.13"
"fastapi==0.94.0"
"ffmpy==0.6.4"
"filelock==3.20.0"
"filterpy==1.4.5"
"fonttools==4.60.1"
"frozenlist==1.8.0"
"fsspec==2025.10.0"
"ftfy==6.1.1"
"future==1.0.0"
"gdown==5.2.0"
"gfpgan==1.3.8"
"gitdb==4.0.12"
"GitPython==3.1.32"
"gradio==3.41.2"
"gradio_client==0.5.0"
"groovy==0.1.2"
"grpcio==1.76.0"
"h11==0.16.0"
"hf-xet==1.2.0"
"httpcore==1.0.9"
"httpx==0.28.1"
"huggingface-hub==0.34.0"
"idna==3.11"
"ImageIO==2.37.2"
"importlib_metadata==8.7.0"
"importlib_resources==6.5.2"
"inflection==0.5.1"
"invisible-watermark==0.2.0"
"Jinja2==3.1.6"
"jsonmerge==1.8.0"
"jsonschema==4.25.1"
"jsonschema-specifications==2025.9.1"
"kiwisolver==1.4.9"
"kornia==0.6.7"
"kornia_rs==0.1.9"
"lark==1.1.2"
"lazy_loader==0.4"
"lightning-fabric==1.9.5"
"lightning-utilities==0.8.0"
"llvmlite==0.45.1"
"lmdb==1.7.5"
"Markdown==3.10"
"markdown-it-py==4.0.0"
"MarkupSafe==2.1.5"
"matplotlib==3.10.7"
"mdurl==0.1.2"
"mpmath==1.3.0"
"multidict==6.7.0"
"narwhals==2.10.2"
"networkx==3.4.2"
"numba==0.62.1"
"numpy==1.26.4"
"omegaconf==2.2.3"
"open-clip-torch==2.20.0"
"opencv-python==4.11.0.86"
"orjson==3.11.4"
"packaging==25.0"
"pandas==2.3.3"
"piexif==1.1.3"
"Pillow==9.5.0"
"pillow-avif-plugin==1.4.3"
"pip==25.3"
"platformdirs==4.5.0"
"propcache==0.4.1"
"protobuf==3.20.0"
"psutil==5.9.5"
"pydantic==1.10.24"
"pydantic_core==2.33.2"
"pydub==0.25.1"
"Pygments==2.19.2"
"pyparsing==3.2.5"
"PySocks==1.7.1"
"python-dateutil==2.9.0.post0"
"python-multipart==0.0.20"
"pytorch-lightning==1.9.5"
"pytorch_lightning==1.9.5"
"pytz==2025.2"
"PyWavelets==1.8.0"
"PyYAML==6.0.3"
"realesrgan==0.3.0"
"referencing==0.37.0"
"regex==2023.12.25"
"requests==2.32.5"
"resize-right==0.0.2"
"rich==14.2.0"
"rpds-py==0.28.0"
"ruff==0.14.3"
"safehttpx==0.1.7"
"safetensors==0.4.2"
"scikit-image==0.24.0"
"scipy==1.15.3"
"semantic-version==2.10.0"
"Send2Trash==1.8.3"
"sentencepiece==0.2.0"
"setuptools==80.9.0"
"shellingham==1.5.4"
"six==1.17.0"
"smmap==5.0.2"
"sniffio==1.3.1"
"soupsieve==2.8"
"spandrel==0.3.4"
"spandrel_extra_arches==0.1.1"
"starlette==0.26.1"
"sympy==1.14.0"
"synr==0.5.0"
"tb-nightly==2.21.0a20251023"
"tensorboard-data-server==0.7.2"
"tifffile==2025.5.10"
"timm==1.0.22"
"tokenizers==0.13.3"
"tomesd==0.1.3"
"tomli==2.3.0"
"tomlkit==0.13.3"
"torch==2.0.1"
"torchaudio==2.9.0"
"torchdiffeq==0.2.3"
"torchmetrics==1.8.2"
"torchsde==0.2.6"
"torchvision==0.15.2"
"tornado==6.3.3"
"tqdm==4.67.1"
"trampoline==0.1.2"
"transformers==4.30.2"
"typer==0.20.0"
"typer-slim==0.20.0"
"typing_extensions==4.15.0"
"typing-inspection==0.4.2"
"tzdata==2025.2"
"urllib3==2.5.0"
"uvicorn==0.38.0"
"wcwidth==0.2.14"
"websockets==11.0.3"
"Werkzeug==3.1.3"
"wheel==0.45.1"
"yapf==0.43.0"
"yarl==1.22.0"
"zipp==3.23.0"
)

# 显示标题
clear
echo ""
echo -e "${CYAN}"                   
echo "	   ▄▄▄  ▄    ▄   ▄▄▄ "
echo "	 ▄▀   ▀ █    █ ▄▀   ▀"
echo "	 █      █    █ █     "
echo "	 █      █    █ █     "
echo "	  ▀▄▄▄▀ ▀▄▄▄▄▀  ▀▄▄▄▀"
echo -e "${WHITE}中国传媒大学${NC}"
echo -e "${CYAN}Communication University of China${NC}"
echo -e "${NC}"

echo ""
echo -e "${BLUE}┌────────────────────────────────────────────┐${NC}"
echo -e "${BLUE}│           🎬 CUC AI 影像工作站           │${NC}"
echo -e "${BLUE}│           macOS 专用优化版本            │${NC}"
echo -e "${BLUE}└────────────────────────────────────────────┘${NC}"
echo ""
echo -e "${YELLOW}制作: ${WHITE}2025级 摄影系 徐嘉盛${NC}"
echo ""

# 进程清理函数
cleanup_processes() {
    echo ""
    echo -e "${YELLOW}🧹 清理进程...${NC}"
    
    # 从文件读取PID和端口
    if [ -f "$PID_FILE" ]; then
        SD_PID=$(cat "$PID_FILE")
        echo -e " ${BLUE}找到SD进程: $SD_PID${NC}"
        
        if kill -0 $SD_PID 2>/dev/null; then
            echo -e " ${BLUE}结束SD进程 $SD_PID...${NC}"
            kill $SD_PID 2>/dev/null
            sleep 2
            if kill -0 $SD_PID 2>/dev/null; then
                echo -e " ${YELLOW}强制结束进程...${NC}"
                kill -9 $SD_PID 2>/dev/null
            fi
            echo -e " ${GREEN}✅ SD进程已结束${NC}"
        else
            echo -e " ${YELLOW}SD进程已不存在${NC}"
        fi
        rm -f "$PID_FILE"
    fi
    
    if [ -f "$PORT_FILE" ]; then
        SD_PORT=$(cat "$PORT_FILE")
        echo -e " ${BLUE}清理端口 $SD_PORT...${NC}"
        rm -f "$PORT_FILE"
    fi
    
    # 清理可能的残留进程
    for port in 7860 7861 7862; do
        pid=$(lsof -ti:$port 2>/dev/null)
        if [ ! -z "$pid" ]; then
            echo -e " ${BLUE}清理端口 $port 的进程 $pid...${NC}"
            kill -9 $pid 2>/dev/null
        fi
    done
    
    # 清理Python相关进程
    pids=$(pgrep -f "webui.py" 2>/dev/null)
    if [ ! -z "$pids" ]; then
        echo -e " ${BLUE}清理webui.py进程...${NC}"
        echo $pids | xargs kill -9 2>/dev/null
    fi
    
    echo -e " ${GREEN}✅ 进程清理完成${NC}"
}

# 设置退出时的清理
trap cleanup_processes EXIT INT TERM

# 系统检测
echo -e "${BLUE}🔍 系统检测${NC}"
echo -e "${BLUE}────────────────────────────────────────────${NC}"
CHIP_TYPE=$(system_profiler SPHardwareDataType 2>/dev/null | grep "Chip" | awk -F: '{print $2}' | xargs)
MACOS_VERSION=$(sw_vers -productVersion)

if [[ $CHIP_TYPE == *"M1"* ]] || [[ $CHIP_TYPE == *"M2"* ]] || [[ $CHIP_TYPE == *"M3"* ]] || [[ $CHIP_TYPE == *"M4"* ]]; then
    echo -e " ${GREEN}🍎 Apple $CHIP_TYPE${NC}"
    echo -e " ${GREEN}📱 macOS $MACOS_VERSION${NC}"
    # Apple Silicon 特殊配置
    export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0
    export MPS_DEVICE=mps
else
    echo -e " ${YELLOW}💻 Intel 芯片${NC}"
    echo -e " ${YELLOW}📱 macOS $MACOS_VERSION${NC}"
fi

# macOS特定说明
echo ""
echo -e "${CYAN}💡 macOS 专用说明${NC}"
echo -e "${BLUE}────────────────────────────────────────────${NC}"
echo -e "${WHITE}• Apple Silicon 芯片使用 MPS (Metal Performance Shaders) 加速${NC}"
echo -e "${WHITE}• 出现的 'CUDA not available' 警告是正常现象${NC}"
echo -e "${WHITE}• 退出脚本时会自动结束所有相关进程${NC}"
echo ""

# 检查现有进程
check_existing_processes() {
    echo -e "${BLUE}🔍 检查现有进程${NC}"
    echo -e "${BLUE}────────────────────────────────────────────${NC}"
    
    local found_process=0
    
    # 检查端口占用
    for port in 7860 7861 7862; do
        pid=$(lsof -ti:$port 2>/dev/null)
        if [ ! -z "$pid" ]; then
            echo -e " ${YELLOW}⚠️  端口 $port 被进程 $pid 占用${NC}"
            found_process=1
        fi
    done
    
    # 检查Python进程
    pids=$(pgrep -f "webui.py" 2>/dev/null)
    if [ ! -z "$pids" ]; then
        echo -e " ${YELLOW}⚠️  发现运行的 webui.py 进程: $pids${NC}"
        found_process=1
    fi
    
    if [ $found_process -eq 1 ]; then
        echo -e " ${BLUE}💡 脚本退出时将自动清理这些进程${NC}"
    else
        echo -e " ${GREEN}✅ 没有发现运行的SD进程${NC}"
    fi
    echo ""
}

# 在系统检测后调用
check_existing_processes

# 目录检查
echo -e "${BLUE}📂 目录检查${NC}"
echo -e "${BLUE}────────────────────────────────────────────${NC}"
if [ -d "stable-diffusion-webui" ]; then
    echo -e " ${GREEN}✅ stable-diffusion-webui 目录存在${NC}"
    if [ -f "stable-diffusion-webui/webui.py" ]; then
        echo -e " ${GREEN}✅ webui.py 存在${NC}"
    else
        echo -e " ${YELLOW}⚠️ 未找到启动脚本${NC}"
    fi
    
    # 检查模型目录
    if [ -d "stable-diffusion-webui/models/Stable-diffusion" ]; then
        model_count=$(find stable-diffusion-webui/models/Stable-diffusion -name "*.ckpt" -o -name "*.safetensors" 2>/dev/null | wc -l)
        if [ $model_count -gt 0 ]; then
            echo -e " ${GREEN}✅ 发现 $model_count 个模型文件${NC}"
        else
            echo -e " ${YELLOW}⚠️ 模型目录为空，首次启动将自动下载${NC}"
        fi
    else
        echo -e " ${YELLOW}⚠️ 模型目录不存在，首次启动将自动创建${NC}"
    fi
else
    echo -e " ${RED}❌ stable-diffusion-webui 目录不存在${NC}"
fi

if [ -d "stable-diffusion-webui/venv" ]; then
    echo -e " ${GREEN}✅ venv 虚拟环境目录存在${NC}"
else
    echo -e " ${YELLOW}⚠️ venv 目录不存在，将自动创建${NC}"
fi

# macOS优化的依赖检查
check_dependencies() {
    echo ""
    echo -e "${YELLOW}🔍 依赖健康检查...${NC}"
    
    if [ ! -d "stable-diffusion-webui/venv" ]; then
        echo -e " ${RED}❌ 虚拟环境不存在${NC}"
        return 1
    fi

    source stable-diffusion-webui/venv/bin/activate
    
    local critical_imports=(
        "torch::torch"
        "Pillow::PIL"
        "numpy::numpy"
        "gradio::gradio"
        "transformers::transformers"
    )
    
    local missing_count=0
    local working_count=0
    
    for import_pair in "${critical_imports[@]}"; do
        IFS='::' read -r package import_name <<< "$import_pair"
        if python3 -c "import $import_name" 2>/dev/null; then
            local version=$(pip show $package 2>/dev/null | grep Version | awk '{print $2}' || echo "未知")
            echo -e " ${GREEN}✅ $package $version${NC}"
            ((working_count++))
        else
            echo -e " ${RED}❌ $package 缺失${NC}"
            ((missing_count++))
        fi
    done

    # 检查MPS支持
    if python3 -c "import torch; print('MPS available:', torch.backends.mps.is_available())" 2>/dev/null | grep -q "MPS available: True"; then
        echo -e " ${GREEN}✅ MPS 加速可用${NC}"
    else
        echo -e " ${YELLOW}⚠️ MPS 不可用，将使用CPU${NC}"
    fi

    if [ $missing_count -eq 0 ]; then
        echo -e " ${GREEN}✅ 所有关键依赖正常${NC}"
        return 0
    else
        echo -e " ${YELLOW}⚠️ $missing_count 个关键依赖缺失${NC}"
        return $missing_count
    fi
}

# macOS优化的依赖安装
install_dependencies() {
    echo ""
    echo -e "${YELLOW}📦 安装 macOS 优化依赖${NC}"
    
    # 检查Python
    if ! command -v python3 &> /dev/null; then
        echo -e " ${RED}❌ Python3 未安装${NC}"
        echo -e " ${BLUE}安装 Python...${NC}"
        if ! command -v brew &> /dev/null; then
            echo -e " ${BLUE}安装 Homebrew...${NC}"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install python3
    else
        echo -e " ${GREEN}✅ Python3: $(python3 --version)${NC}"
    fi

    # 创建虚拟环境
    if [ ! -d "stable-diffusion-webui/venv" ]; then
        echo -e " ${BLUE}创建虚拟环境...${NC}"
        cd stable-diffusion-webui
        python3 -m venv venv
        cd ..
    fi

    # 激活环境
    source stable-diffusion-webui/venv/bin/activate

    # 配置pip
    echo -e " ${BLUE}配置 pip 环境...${NC}"
    python3 -m pip install --upgrade pip setuptools wheel -i $PYPI_MIRROR
    
    # 设置pip配置
    pip config set global.index-url $PYPI_MIRROR
    pip config set global.timeout 300
    pip config set global.retries 3

    # 安装macOS优化的PyTorch
    echo -e " ${BLUE}安装 PyTorch (macOS 优化)...${NC}"
    if [[ $CHIP_TYPE == *"M1"* ]] || [[ $CHIP_TYPE == *"M2"* ]] || [[ $CHIP_TYPE == *"M3"* ]]; then
        # Apple Silicon
        pip install torch torchvision torchaudio -i $PYPI_MIRROR
    else
        # Intel Mac
        pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
    fi

    # 安装兼容的依赖包
    echo -e " ${BLUE}安装兼容的依赖包...${NC}"
    local installed_count=0
    local total_count=${#COMPATIBLE_PACKAGES[@]}
    
    for package in "${COMPATIBLE_PACKAGES[@]}"; do
        ((installed_count++))
        echo -e " ${BLUE}[$installed_count/$total_count] 安装: $package${NC}"
        if ! pip install "$package" --timeout 300; then
            echo -e " ${YELLOW}尝试备用镜像...${NC}"
            if ! pip install "$package" -i $PYPI_MIRROR_BAK --timeout 300; then
                echo -e " ${YELLOW}跳过: $package${NC}"
            fi
        fi
    done

    # 验证安装
    echo -e " ${BLUE}验证安装结果...${NC}"
    check_dependencies
    
    echo -e " ${GREEN}✅ 依赖安装完成${NC}"
}

# macOS优化的环境清理
clean_environment() {
    echo ""
    echo -e "${YELLOW}🧹 清理环境${NC}"
    
    # 清理端口占用
    for port in 7860 7861 7862; do
        pid=$(lsof -ti:$port 2>/dev/null)
        if [ ! -z "$pid" ]; then
            kill -9 $pid 2>/dev/null
            echo -e " ${BLUE}清理端口 $port${NC}"
        fi
    done
    
    # 清理macOS系统缓存
    echo -e " ${BLUE}清理系统缓存...${NC}"
    sudo purge 2>/dev/null || true
    
    sleep 2
    echo -e " ${GREEN}✅ 环境清理完成${NC}"
}

# macOS启动监控
monitor_macos_startup() {
    local log_file="$1"
    local pid="$2"
    local port="$3"
    
    local start_time=$(date +%s)
    local model_downloaded=0
    
    echo -e "${CYAN}🚀 启动监控中...${NC}"
    echo -e "${BLUE}────────────────────────────────────────────${NC}"
    echo -e "${YELLOW}💡 提示: CUDA警告在macOS上是正常现象${NC}"
    echo -e "${YELLOW}💡 提示: 首次运行模型需要下载，请等待...${NC}"
    echo ""
    
    # 设置超时（2小时）
    local timeout=$((2 * 60 * 60))
    
    while [ $(( $(date +%s) - start_time )) -lt $timeout ]; do
        # 检查进程是否存活
        if ! kill -0 $pid 2>/dev/null; then
            echo -e "${RED}❌ 启动进程已退出${NC}"
            return 1
        fi
        
        # 检查端口是否就绪 - 这是主要的成功标准
        if curl -s http://127.0.0.1:$port > /dev/null 2>&1; then
            echo -e "${GREEN}✅ WebUI 服务已启动！${NC}"
            return 0
        fi
        
        # 检查日志中的关键信息（但不作为失败条件）
        if [ -f "$log_file" ]; then
            # 检查模型下载完成
            if [ $model_downloaded -eq 0 ] && tail -n 20 "$log_file" | grep -q -i "model.*download.*complete\|download.*finished"; then
                echo -e "${GREEN}📦 模型下载完成！${NC}"
                model_downloaded=1
            fi
            
            # 检查启动完成信息
            if tail -n 10 "$log_file" | grep -q "Running on.*http://"; then
                echo -e "${GREEN}🎉 检测到服务运行信息${NC}"
                sleep 5
                continue
            fi
        fi
        
        # 每45秒显示一次状态
        local current_time=$(date +%s)
        if [ $((current_time - start_time)) -ge 45 ] && [ $(((current_time - start_time) % 45)) -eq 0 ]; then
            local elapsed=$((current_time - start_time))
            local minutes=$((elapsed / 60))
            local seconds=$((elapsed % 60))
            
            if [ $model_downloaded -eq 1 ]; then
                echo -e "${YELLOW}⏳ 服务启动中... 已等待 ${minutes}分${seconds}秒${NC}"
            else
                echo -e "${BLUE}⏳ 初始化进行中... 已等待 ${minutes}分${seconds}秒${NC}"
            fi
        fi
        
        sleep 5
    done
    
    echo -e "${YELLOW}⚠️ 启动时间较长，但进程仍在运行${NC}"
    echo -e "${BLUE}💡 建议: 检查端口 $port 是否可访问${NC}"
    return 0  # 在macOS上，即使超时也不立即认为失败
}

# 保存进程信息
save_process_info() {
    local pid=$1
    local port=$2
    echo $pid > "$PID_FILE"
    echo $port > "$PORT_FILE"
    echo -e " ${GREEN}✅ 进程信息已保存 (PID: $pid, Port: $port)${NC}"
}

# 手动停止SD进程
stop_sd_process() {
    echo ""
    echo -e "${YELLOW}🛑 手动停止SD进程${NC}"
    cleanup_processes
}

# macOS优化的启动函数
start_webui() {
    echo ""
    echo -e "${BLUE}🚀 启动 Stable Diffusion (macOS)${NC}"
    echo -e "${BLUE}────────────────────────────────────────────${NC}"
    
    # 检查环境
    if [ ! -d "stable-diffusion-webui/venv" ]; then
        echo -e " ${YELLOW}⚠️ 虚拟环境不存在，自动安装依赖${NC}"
        install_dependencies
    else
        # 检查依赖是否正常
        if ! check_dependencies; then
            echo -e " ${YELLOW}⚠️ 依赖检查失败，重新安装依赖${NC}"
            install_dependencies
        else
            echo -e " ${GREEN}✅ 依赖检查通过${NC}"
        fi
    fi

    # 检查模型文件
    local model_count=0
    if [ -d "stable-diffusion-webui/models/Stable-diffusion" ]; then
        model_count=$(find stable-diffusion-webui/models/Stable-diffusion -name "*.ckpt" -o -name "*.safetensors" 2>/dev/null | wc -l)
    fi
    
    if [ $model_count -eq 0 ]; then
        echo -e "${YELLOW}📦 首次启动将下载基础模型 (约4GB)${NC}"
        echo -e "${CYAN}💡 请保持网络连接稳定${NC}"
        echo ""
    fi

    # 清理环境
    clean_environment
    
    cd stable-diffusion-webui
    
    if [ ! -d "venv" ]; then
        echo -e " ${RED}❌ 虚拟环境创建失败${NC}"
        cd ..
        return 1
    fi

    # 激活环境
    source venv/bin/activate

    # 设置macOS优化的环境变量
    export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0
    export MPS_DEVICE=mps
    export HF_ENDPOINT=https://hf-mirror.com
    export GIT_PYTHON_REFRESH=quiet
    
    # 针对macOS的优化参数
    export COMMANDLINE_ARGS="--listen --skip-torch-cuda-test --no-half"

    # 清理旧日志
    rm -f ../sd_output.log

    echo ""
    echo -e "${BLUE}🎯 启动进度${NC}"
    echo -e "${BLUE}────────────────────────────────────────────${NC}"

    # 查找启动脚本
    if [ ! -f "webui.py" ]; then
        echo -e " ${RED}❌ 未找到 webui.py${NC}"
        cd ..
        return 1
    fi

    echo -e " ${GREEN}使用 webui.py 启动${NC}"

    # 尝试不同端口
    SUCCESS=0
    for port in 7860 7861 7862; do
        if lsof -i :$port > /dev/null 2>&1; then
            echo -e " ${YELLOW}端口 $port 被占用，跳过${NC}"
            continue
        fi

        echo -e " ${BLUE}尝试端口: $port${NC}"
        
        # 启动服务（使用macOS优化参数）
        echo -e " ${BLUE}启动服务...${NC}"
        python3 webui.py --listen --port $port --skip-torch-cuda-test --no-half > ../sd_output.log 2>&1 &
        PID=$!

        # 等待进程启动
        sleep 15

        # 检查进程是否还在运行
        if ! kill -0 $PID 2>/dev/null; then
            echo -e " ${RED}❌ 启动进程已退出${NC}"
            if [ -f "../sd_output.log" ]; then
                echo -e "${YELLOW}检查日志...${NC}"
                tail -20 ../sd_output.log
            fi
            continue
        fi

        echo -e " ${GREEN}✅ 启动进程运行中 (PID: $PID)${NC}"

        # 保存进程信息
        save_process_info $PID $port

        # 监控启动进度
        if monitor_macos_startup "../sd_output.log" "$PID" "$port"; then
            SUCCESS=1
            FINAL_PORT=$port
            FINAL_PID=$PID
            break
        else
            echo -e " ${YELLOW}端口 $port 启动监控失败，尝试下一个...${NC}"
            kill $PID 2>/dev/null
            rm -f "$PID_FILE" "$PORT_FILE"
            sleep 5
        fi
    done

    cd ..

    # 显示结果
    echo ""
    echo -e "${BLUE}────────────────────────────────────────────${NC}"
    if [ $SUCCESS -eq 1 ] || [ ! -z "$FINAL_PID" ]; then
        echo ""
        echo -e "${GREEN}┌────────────────────────────────────────────┐${NC}"
        echo -e "${GREEN}│ 🎉 启动成功!                             │${NC}"
        echo -e "${GREEN}└────────────────────────────────────────────┘${NC}"
        echo ""
        echo -e "${CYAN}🌐 访问地址: ${WHITE}http://127.0.0.1:${FINAL_PORT:-7860}${NC}"
        echo ""
        echo -e "${YELLOW}📊 启动信息${NC}"
        echo -e " 端口: ${GREEN}${FINAL_PORT:-7860}${NC}"
        echo -e " 进程: ${GREEN}${FINAL_PID:-$PID}${NC}"
        echo -e " 芯片: ${GREEN}$CHIP_TYPE${NC}"
        echo -e " 加速: ${GREEN}MPS (Metal Performance Shaders)${NC}"
        echo ""

        # 显示模型状态
        local model_count=0
        if [ -d "stable-diffusion-webui/models/Stable-diffusion" ]; then
            model_count=$(find stable-diffusion-webui/models/Stable-diffusion -name "*.ckpt" -o -name "*.safetensors" 2>/dev/null | wc -l)
        fi
        
        if [ $model_count -eq 0 ]; then
            echo -e "${YELLOW}📦 模型状态: 使用基础模型${NC}"
        else
            echo -e "${GREEN}📦 模型状态: 已加载 $model_count 个模型${NC}"
        fi
        
        # 显示macOS特定提示
        echo ""
        echo -e "${CYAN}💡 macOS 使用提示${NC}"
        echo -e "${BLUE}────────────────────────────────────────────${NC}"
        echo -e "${WHITE}• 'CUDA not available' 警告是正常现象${NC}"
        echo -e "${WHITE}• Apple Silicon 使用 MPS 进行GPU加速${NC}"
        echo -e "${WHITE}• 首次生成图片可能需要较长时间${NC}"
        echo -e "${WHITE}• 退出脚本时会自动结束SD进程${NC}"
        echo ""

        # 自动打开浏览器
        echo -e "${CYAN}正在打开浏览器...${NC}"
        open "http://127.0.0.1:${FINAL_PORT:-7860}" 2>/dev/null ||
        echo -e "${YELLOW}⚠️ 无法自动打开浏览器，请手动访问上述地址${NC}"
        
        echo ""
        echo -e "${BLUE}💡 提示: ${WHITE}开始AI创作之旅！${NC}"
        echo ""
        echo -e "${YELLOW}📋 日志文件: ${WHITE}$(pwd)/sd_output.log${NC}"
        if [ ! -z "$FINAL_PID" ]; then
            echo -e "${YELLOW}🛑 停止命令: ${WHITE}kill -9 $FINAL_PID${NC}"
        fi
        echo -e "${YELLOW}🔧 自动清理: ${WHITE}退出脚本时自动结束进程${NC}"
    else
        echo ""
        echo -e "${YELLOW}┌────────────────────────────────────────────┐${NC}"
        echo -e "${YELLOW}│ ⚠️  启动状态待确认                        │${NC}"
        echo -e "${YELLOW}└────────────────────────────────────────────┘${NC}"
        echo ""
        echo -e "${CYAN}可能的情况:${NC}"
        echo -e " • 服务仍在启动中（特别是首次运行）"
        echo -e " • 模型下载进行中"
        echo -e " • 端口访问需要更多时间"
        echo ""
        echo -e "${BLUE}💡 建议操作:${NC}"
        echo -e " 1. 等待几分钟后访问: ${WHITE}http://127.0.0.1:7860${NC}"
        echo -e " 2. 查看实时日志: ${WHITE}tail -f $(pwd)/sd_output.log${NC}"
        echo -e " 3. 检查进程状态: ${WHITE}ps aux | grep webui.py${NC}"
        echo ""
        echo -e "${GREEN}📋 如果页面可以访问，说明启动成功！${NC}"
    fi
}

# 下载WebUI
download_webui() {
    echo ""
    echo -e "${YELLOW}📥 下载 WebUI${NC}"
    
    if [ -d "stable-diffusion-webui" ]; then
        echo -e " ${BLUE}WebUI 已存在，跳过下载${NC}"
        return 0
    fi

    if command -v git &> /dev/null; then
        echo -e " ${BLUE}使用 Git 克隆...${NC}"
        git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
    else
        echo -e " ${RED}❌ Git 未安装${NC}"
        echo -e " ${BLUE}安装 Git...${NC}"
        brew install git
        git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
    fi

    if [ $? -eq 0 ]; then
        echo -e " ${GREEN}✅ 下载完成${NC}"
    else
        echo -e " ${RED}❌ 下载失败${NC}"
        return 1
    fi
}

# 系统诊断
diagnose_system() {
    echo ""
    echo -e "${CYAN}🔧 macOS 系统诊断${NC}"
    echo -e "${BLUE}────────────────────────────────────────────${NC}"
    echo -e "系统版本: $(sw_vers -productVersion)"
    echo -e "芯片类型: $CHIP_TYPE"
    echo -e "内存: $(sysctl -n hw.memsize 2>/dev/null | awk '{print $1/1024/1024/1024 " GB"}')"
    echo -e "Python: $(python3 --version 2>/dev/null || echo '未安装')"
    echo -e "Pip: $(pip --version 2>/dev/null || echo '未安装')"
    echo -e "Git: $(git --version 2>/dev/null || echo '未安装')"
    
    if [ -d "stable-diffusion-webui" ]; then
        echo -e "WebUI目录: ${GREEN}存在${NC}"
        if [ -d "stable-diffusion-webui/venv" ]; then
            echo -e "虚拟环境: ${GREEN}存在${NC}"
            check_dependencies
        else
            echo -e "虚拟环境: ${RED}缺失${NC}"
        fi
        
        # 模型文件检查
        if [ -d "stable-diffusion-webui/models/Stable-diffusion" ]; then
            model_count=$(find stable-diffusion-webui/models/Stable-diffusion -name "*.ckpt" -o -name "*.safetensors" 2>/dev/null | wc -l)
            echo -e "模型文件: ${GREEN}$model_count 个${NC}"
        else
            echo -e "模型目录: ${YELLOW}未创建${NC}"
        fi
    else
        echo -e "WebUI目录: ${RED}缺失${NC}"
    fi
}

# 修复常见问题
fix_common_issues() {
    echo ""
    echo -e "${YELLOW}🔧 修复常见问题${NC}"
    
    # 清理缓存
    echo -e " ${BLUE}清理 pip 缓存...${NC}"
    pip cache purge 2>/dev/null || true
    
    # 重新安装关键包
    echo -e " ${BLUE}重新安装关键依赖...${NC}"
    pip install --force-reinstall "torch" "torchvision" "torchaudio"
    
    # 修复权限问题
    echo -e " ${BLUE}修复文件权限...${NC}"
    chmod +x stable-diffusion-webui/webui.py 2>/dev/null || true
    
    echo -e " ${GREEN}✅ 修复完成${NC}"
}

# 显示进程状态
show_process_status() {
    echo ""
    echo -e "${CYAN}🔍 当前进程状态${NC}"
    echo -e "${BLUE}────────────────────────────────────────────${NC}"
    
    if [ -f "$PID_FILE" ]; then
        SD_PID=$(cat "$PID_FILE")
        SD_PORT=$(cat "$PORT_FILE" 2>/dev/null || echo "未知")
        if kill -0 $SD_PID 2>/dev/null; then
            echo -e " ${GREEN}✅ SD进程运行中${NC}"
            echo -e "   进程ID: $SD_PID"
            echo -e "   端口: $SD_PORT"
            echo -e "   访问地址: http://127.0.0.1:$SD_PORT"
        else
            echo -e " ${RED}❌ SD进程已停止${NC}"
            rm -f "$PID_FILE" "$PORT_FILE"
        fi
    else
        echo -e " ${YELLOW}⚠️ 没有记录的SD进程${NC}"
    fi
    
    # 检查实际运行进程
    pids=$(pgrep -f "webui.py" 2>/dev/null)
    if [ ! -z "$pids" ]; then
        echo -e " ${YELLOW}⚠️ 发现未记录的webui.py进程: $pids${NC}"
    fi
}

# 主菜单
main_menu() {
    echo ""
    echo -e "${CYAN}请选择操作:${NC}"
    echo -e " ${GREEN}1${NC}) 完整安装并启动"
    echo -e " ${GREEN}2${NC}) 仅安装依赖"
    echo -e " ${GREEN}3${NC}) 仅启动 WebUI"
    echo -e " ${GREEN}4${NC}) 下载 WebUI"
    echo -e " ${GREEN}5${NC}) 修复常见问题"
    echo -e " ${GREEN}6${NC}) 系统诊断"
    echo -e " ${GREEN}7${NC}) 查看进程状态"
    echo -e " ${GREEN}8${NC}) 停止SD进程"
    echo -e " ${GREEN}9${NC}) 退出"
    echo ""
    read -p "请输入选择 [1-9]: " choice

    case $choice in
        1)
            echo -e "${BLUE}🚀 开始完整安装流程...${NC}"
            echo -e "${BLUE}────────────────────────────────────────────${NC}"
            
            # 步骤1: 下载WebUI
            if [ ! -d "stable-diffusion-webui" ]; then
                echo -e "${YELLOW}步骤1: 下载 WebUI${NC}"
                download_webui
                if [ $? -ne 0 ]; then
                    echo -e "${RED}❌ WebUI下载失败${NC}"
                    return 1
                fi
            else
                echo -e "${GREEN}✅ WebUI 已存在，跳过下载${NC}"
            fi
            
            # 步骤2: 安装依赖
            echo -e "${YELLOW}步骤2: 安装依赖${NC}"
            install_dependencies
            if [ $? -ne 0 ]; then
                echo -e "${YELLOW}⚠️ 依赖安装遇到问题，但继续启动流程${NC}"
            fi
            
            # 步骤3: 启动WebUI
            echo -e "${YELLOW}步骤3: 启动 WebUI${NC}"
            start_webui
            ;;
        2)
            install_dependencies
            ;;
        3)
            start_webui
            ;;
        4)
            download_webui
            ;;
        5)
            fix_common_issues
            ;;
        6)
            diagnose_system
            ;;
        7)
            show_process_status
            ;;
        8)
            stop_sd_process
            ;;
        9)
            echo -e "${BLUE}再见！${NC}"
            cleanup_processes
            exit 0
            ;;
        *)
            echo -e "${RED}无效选择${NC}"
            ;;
    esac

    echo ""
    read -p "按回车键返回主菜单..."
    main_menu
}

# 启动主菜单
main_menu