# CUC AI 影像工作站

<div align="center">

**专为 macOS 优化的 Stable Diffusion WebUI 自动化部署脚本**

[English](README_EN.md) | **简体中文**

</div>

## ✨ 特性

### 🍎 macOS 专属优化
- **Apple Silicon 原生支持** - M1/M2/M3 芯片的 MPS 加速
- **Intel Mac 兼容** - 完整的 CPU 优化支持
- **系统集成** - 自动清理、进程管理、资源优化

### 🚀 一键部署
- **自动环境配置** - Python 虚拟环境、依赖管理
- **智能镜像源** - 国内镜像加速下载
- **兼容性保障** - 经过测试的依赖包版本

### 🎯 专业功能
- **进程管理** - 自动启动、停止、状态监控
- **健康检查** - 依赖验证、系统诊断
- **错误恢复** - 自动重试、故障修复

## 📋 系统要求

### 最低配置
- **操作系统**: macOS 12.0 (Monterey) 或更高版本
- **芯片**: Apple Silicon (M1/M2/M3) 或 Intel Core i5 及以上
- **内存**: 8 GB RAM
- **存储**: 20 GB 可用空间

### 推荐配置
- **操作系统**: macOS 13.0 (Ventura) 或更高版本  
- **芯片**: Apple Silicon (M2/M3)
- **内存**: 16 GB RAM 或更多
- **存储**: 40 GB 可用空间 (用于模型存储)

## 🛠 快速开始

### 方法一：一键安装（推荐）

```bash
# 克隆项目
git clone https://github.com/your-username/cuc-ai-workstation.git
cd cuc-ai-workstation

# 赋予执行权限
chmod +x setup_macos.sh

# 运行安装脚本
./setup_macos.sh
```

### 方法二：手动步骤

1. **下载项目**
   ```bash
   git clone https://github.com/your-username/cuc-ai-workstation.git
   cd cuc-ai-workstation
   ```

2. **运行脚本**
   ```bash
   ./setup_macos.sh
   ```

3. **选择安装选项**
   - 选择 `1` 进行完整安装
   - 脚本将自动处理所有依赖和环境配置

## 📖 使用指南

### 首次运行

1. **启动脚本**
   ```bash
   ./setup_macos.sh
   ```

2. **主菜单选项**
   ```
   🎯 CUC AI 影像工作站 - 主菜单
   
   1) 完整安装并启动
   2) 仅安装依赖  
   3) 仅启动 WebUI
   4) 下载 WebUI
   5) 修复常见问题
   6) 系统诊断
   7) 查看进程状态
   8) 停止SD进程
   9) 退出
   ```

3. **推荐选择 `1` 进行完整安装**

### 正常使用

1. **启动服务**
   - 运行脚本并选择 `3` (仅启动 WebUI)
   - 或直接选择 `1` (完整安装并启动)

2. **访问界面**
   - 脚本启动后自动打开浏览器
   - 手动访问: `http://127.0.0.1:7860`

3. **停止服务**
   - 在脚本主菜单中选择 `8`
   - 或直接关闭终端窗口 (自动清理)

## 🔧 功能详解

### 1. 智能依赖管理
- **自动检测** - 检查现有环境状态
- **版本控制** - 兼容的依赖包版本
- **镜像加速** - 国内 PyPI 镜像源
- **错误恢复** - 安装失败自动重试

### 2. macOS 优化配置
```bash
# Apple Silicon 优化
export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0
export MPS_DEVICE=mps

# 性能优化参数
export COMMANDLINE_ARGS="--listen --skip-torch-cuda-test --no-half"
```

### 3. 进程监控系统
- **自动端口管理** - 7860, 7861, 7862 端口轮询
- **进程守护** - 自动重启失败进程
- **资源清理** - 退出时自动清理所有相关进程

### 4. 健康诊断
```bash
# 系统诊断功能
✅ 芯片类型检测
✅ 内存使用监控  
✅ 依赖包验证
✅ 模型文件检查
✅ 端口占用检测
```

## 🗂 项目结构

```
cuc-ai-workstation/
├── setup_macos.sh          # 主安装脚本
├── README.md               # 中文文档
├── README_EN.md            # 英文文档
├── .sd_webui.pid          # 进程ID记录
├── .sd_webui.port         # 端口记录
└── sd_output.log          # 运行日志
```

## 🚨 故障排除

### 常见问题

#### 1. 启动失败
**症状**: 进程启动后立即退出
**解决**: 
- 选择菜单 `5` 修复常见问题
- 检查日志文件 `sd_output.log`

#### 2. 依赖安装缓慢
**症状**: pip 安装超时
**解决**:
- 脚本自动切换镜像源
- 检查网络连接

#### 3. 端口占用
**症状**: 无法访问 7860 端口
**解决**:
- 脚本自动尝试 7861, 7862 端口
- 使用菜单 `8` 停止现有进程

#### 4. 模型下载失败
**症状**: 首次启动卡在模型下载
**解决**:
- 检查网络连接
- 手动下载模型到 `stable-diffusion-webui/models/Stable-diffusion/`

### 高级调试

```bash
# 查看详细日志
tail -f sd_output.log

# 检查进程状态
ps aux | grep webui.py

# 手动清理环境
./setup_macos.sh
# 然后选择 8 (停止SD进程)
```

## 📝 版本信息

### 当前版本
- **脚本版本**: v2.0.0
- **WebUI 版本**: Automatic1111 最新版
- **PyTorch**: 2.0.1 (macOS 优化版)
- **测试平台**: macOS 14.0, Apple M2 Pro

### 更新日志
- **v2.0.0** - 完全重写，macOS 专属优化
- **v1.5.0** - 添加 Apple Silicon 支持
- **v1.0.0** - 初始版本发布

## 🤝 贡献指南

我们欢迎贡献！请参考以下步骤：

1. Fork 本项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🙏 致谢

- **中国传媒大学** - 提供学术支持
- **Automatic1111** - Stable Diffusion WebUI
- **开源社区** - 依赖包维护者

## 📞 支持

### 问题反馈
- [创建 Issue](https://github.com/your-username/cuc-ai-workstation/issues)
- 邮件联系: your-email@cuc.edu.cn

### 文档资源
- [详细使用教程](docs/TUTORIAL.md)
- [故障排除指南](docs/TROUBLESHOOTING.md)
- [性能优化建议](docs/OPTIMIZATION.md)

---

<div align="center">

**中国传媒大学 · 摄影系**  
*让创意与技术完美融合*

[English Documentation](README_EN.md) | [返回顶部](#cuc-ai-影像工作站)

</div>
