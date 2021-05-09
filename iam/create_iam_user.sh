#!/bin/bash
# 创建一个IAM用户组
aws iam create-group --group-name Administrators

# 获取用户组列表
aws iam list-groups

# 关联托管策略到用户组
aws iam attach-group-policy --group-name Administrators --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

# 获取用户组关联的托管策略
aws iam list-attached-group-policies --group-name Administrators

# 获取某一托管策略的元数据
aws iam get-policy --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

# 创建IAM用户
aws iam create-user --user-name jerry --tags '
[
    {
        "Key": "email",
        "Value": "jerry@example.com"
    },
    {
        "Key": "department",
        "Value": "Human Resources"
    }
]'

# 为IAM用户创建密码，用于登录AWS管理控制台
# 生成login-profile模板
aws iam create-login-profile --generate-cli-skeleton  > create-login-profile.json
# 修改模板文件create-login-profile.json
# cat create-login-profile.json
# {
#     "UserName": "jerry",
#     "Password": "Jerr^@346",
#     "PasswordResetRequired": true
# }
# 应用模板文件
aws iam create-login-profile --cli-input-json file://create-login-profile.json

# 为IAM用户生成访问密钥，用于编程访问
aws iam create-access-key --user-name jerry

# 将用户添加到用户组
aws iam add-user-to-group --generate-cli-skeleton > user-goup.json
# 修改模板文件内容
aws iam add-user-to-group --cli-input-json file:///root/user-goup.json