# Stable Diffusion 一键安装工具
> 中国传媒大学 AIGC 课程 - Stable Diffusion 一键部署工具

## 🎯 项目简介

专为 macOS 设计的 Stable Diffusion WebUI 全自动安装脚本，集成了国内镜像加速和智能依赖修复功能，让 AI 图像生成变得简单易用。

## ✨ 核心特性

- 🚀 全自动安装 - 从零开始自动完成所有环境配置
- 🌐 国内镜像加速 - 所有下载源均已替换为国内镜像
- 🔧 智能依赖修复 - 自动检测并修复缺失的依赖包
- 🎨 美观界面 - 彩色终端输出和进度显示
- 🔄 多端口重试 - 自动尝试 7860、7861、7862 端口
- 📊 实时监控 - 详细的日志输出和状态提示

## 📋 系统要求

### 最低配置
- 操作系统: macOS 10.15 或更高版本
- 内存: 8GB RAM
- 存储空间: 10GB 可用空间
- 网络: 稳定的互联网连接

### 推荐配置
- 芯片: Apple Silicon (M1/M2/M3) 或 Intel Core i5 以上
- 内存: 16GB RAM 或更多
- 存储空间: 20GB SSD 可用空间

## 🚀 快速开始

### 第一步：下载脚本
```bash
# 克隆项目或直接下载脚本
git clone https://github.com/Harry-XUXU/stable-diffusion-cuc.git
cd stable-diffusion-cuc
```

### 第二步：运行安装
```bash
# 赋予执行权限
chmod +x CUC_AI_Studio.command

# 运行安装脚本
./CUC_AI_Studio.command
```

### 第三步：选择安装选项
运行脚本后，会出现以下菜单：
```
请选择操作:
  1) 完整安装并启动 Stable Diffusion
  2) 仅安装依赖
  3) 仅启动 Stable Diffusion
  4) 下载 WebUI (国内镜像)
  5) 修复依赖问题
  6) 智能依赖扫描
  7) 系统诊断
  8) 退出
```

推荐选择选项 1 进行完整安装。

## 📖 详细使用指南

### 选项说明

#### 1. 完整安装并启动
- ✅ 自动安装 Python 和所有依赖
- ✅ 下载 Stable Diffusion WebUI
- ✅ 自动启动服务并打开浏览器
- ✅ 智能检测和修复依赖问题

适用场景: 首次安装或重新安装

#### 2. 仅安装依赖
- 🔧 重新创建虚拟环境
- 📦 安装所有必要的 Python 包
- 🔍 自动检测和修复缺失依赖

适用场景: 环境损坏或依赖缺失

#### 3. 仅启动
- 🚀 快速启动 WebUI 服务
- 🔍 启动前自动检查依赖完整性
- 🔄 自动修复发现的依赖问题

适用场景: 依赖已安装，只需启动服务

#### 4. 下载 WebUI
- 🌐 从国内 Gitee 镜像下载（推荐）
- ⚡ Git 克隆（备用方案）
- 📖 手动下载指引

适用场景: WebUI 代码缺失或需要更新

#### 5. 修复依赖问题
- 🔍 自动扫描常见缺失包
- 📦 一键安装所有缺失依赖
- 🔄 使用国内镜像确保下载成功

适用场景: 启动失败，提示缺失包

#### 6. 智能依赖扫描
- 📊 全面扫描依赖状态
- 📋 分析日志文件中的错误
- 🛠️ 提供精准修复方案

适用场景: 深度诊断依赖问题

#### 7. 系统诊断
- 💻 显示系统信息
- 📁 检查目录结构
- 🧠 检测内存状态
- 📦 验证依赖安装情况

适用场景: 排查环境问题

## 🐛 故障排除

### 常见问题及解决方案

#### Q1: 出现 "ModuleNotFoundError: No module named 'xxx'" 错误
解决方案:
```bash
# 选择菜单选项 5 或 6 进行自动修复
# 或手动安装缺失包:
source venv/bin/activate
pip install [缺失包名] -i https://pypi.tuna.tsinghua.edu.cn/simple
```

#### Q2: 下载过程中网络超时
解决方案:
- 脚本会自动重试和切换镜像源
- 检查网络连接稳定性
- 可尝试切换网络环境后重新运行

#### Q3: 端口被占用
解决方案:
- 脚本会自动尝试 7860、7861、7862 三个端口
- 如需手动指定端口，可修改脚本中的端口列表

#### Q4: 内存不足导致崩溃
解决方案:
```bash
# 关闭其他应用程序释放内存
# 重启电脑后再次尝试
# 在启动参数中添加内存优化选项:
python webui.py --medvram --lowvram
```

### 故障排除流程

1. 首先尝试: 选项 3 (仅启动) - 自动修复依赖
2. 如果失败: 选项 5 (修复依赖问题) - 针对性修复
3. 仍然失败: 选项 6 (智能依赖扫描) - 深度诊断
4. 最后手段: 选项 1 (完整重新安装) - 彻底重装

## 🔧 高级用法

### 手动启动命令
```bash
source venv/bin/activate
cd stable-diffusion-webui

# 基础启动
python webui.py --listen --port 7860

# 带优化参数的启动
python webui.py --listen --port 7860 --medvram --no-half
```

### 查看实时日志
```bash
tail -f sd_output.log
```

### 停止服务
```bash
# 查找进程ID
ps aux | grep webui.py

# 停止进程
kill -9 [进程ID]

# 或使用脚本自动清理
./CUC_AI_Studio.sh
# 选择选项 3，脚本会自动清理旧进程
```

## 💡 使用技巧

### 性能优化
- Apple Silicon 芯片: 自动启用 MPS 加速
- 内存优化: 使用 `--medvram` 参数减少内存占用
- 显存优化: 使用 `--lowvram` 参数优化显存使用

### 模型管理
- 模型文件默认位置: `stable-diffusion-webui/models/`
- 推荐模型存放路径:
  - Checkpoint 模型: `models/Stable-diffusion/`
  - VAE 模型: `models/VAE/`
  - Lora 模型: `models/Lora/`

### 网络访问
- 默认监听地址: `http://127.0.0.1:7860`
- 如需局域网访问，脚本已自动添加 `--listen` 参数
- 访问地址会在启动成功后自动显示

## 📁 项目结构

```
stable-diffusion-cuc-main/
├── CUC_AI_Studio.sh          # 主安装脚本
├── venv/                     # Python 虚拟环境
├── stable-diffusion-webui/   # WebUI 主程序
│   ├── launch.py
│   ├── webui.py
│   └── models/
├── sd_output.log            # 运行日志
└── README.md               # 说明文档
```

## 🆘 获取帮助

如果遇到脚本无法解决的问题：

1. 查看完整日志
   ```bash
   cat sd_output.log
   ```

2. 运行系统诊断
   ```bash
   ./CUC_AI_Studio.sh
   # 选择选项 7
   ```

3. 检查依赖状态
   ```bash
   ./CUC_AI_Studio.sh
   # 选择选项 6
   ```

4. 提交问题
   - 记录具体的错误信息
   - 包含系统诊断信息
   - 描述问题重现步骤

## 🔄 更新日志

### v1.0.0 (当前版本)
- ✅ 基础一键安装功能
- ✅ 国内镜像加速
- ✅ 智能依赖修复
- ✅ 多端口自动重试
- ✅ 实时进度显示

### 计划功能
- 🔄 自动更新检查
- 📦 模型管理功能
- 🎨 主题自定义
- 🔧 更多优化参数

## 📄 许可证

本项目仅供学习和研究使用，请遵守相关软件的使用许可。

## 👥 贡献者

- 制作: 2025级 摄影系 徐嘉盛
- 学校: 中国传媒大学
- 学院: 摄影系

## 🙏 致谢

特别感谢以下项目和技术支持：

### 开源项目
- [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui) - 提供了强大的 Stable Diffusion WebUI
- [Homebrew](https://brew.sh/) - macOS 包管理工具
- 清华大学 TUNA 镜像站 - 提供稳定的国内镜像服务
- 阿里云镜像站 - 备用镜像源支持

### AI 技术支持
🤖 特别感谢 [DeepSeek](https://www.deepseek.com/) AI 助手

在本项目的开发过程中，DeepSeek 提供了 invaluable 的技术支持：

- 代码调试与优化 - 帮助解决了多个复杂的依赖兼容性问题
- 脚本逻辑完善 - 优化了安装流程和错误处理机制
- 技术方案咨询 - 为 macOS 环境下的特殊问题提供了专业解决方案
- 文档编写辅助 - 协助完善了使用说明和故障排除指南

DeepSeek 的强大代码理解和生成能力，让这个项目的开发效率大大提升，解决了许多技术难题。

### 技术社区
- Stack Overflow 社区
- GitHub 开源社区
- 各类技术博客和教程作者

---

开始你的 AI 创作之旅吧！ 🎨✨

如有问题，请先查阅本文档的故障排除部分，或运行脚本的诊断功能。

---
*本项目在 DeepSeek AI 的协助下完成开发，特此致谢！*
