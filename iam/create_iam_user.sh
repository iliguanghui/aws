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

# 为IAM用户生成访问密钥，用于编程访问（最多创建两个，Cannot exceed quota for AccessKeysPerUser: 2）
aws iam create-access-key --user-name jerry

# 将用户添加到用户组
aws iam add-user-to-group --generate-cli-skeleton > user-goup.json
# 修改模板文件内容
aws iam add-user-to-group --cli-input-json file:///root/user-goup.json

# 直接为用户关联策略
aws iam attach-user-policy --user-name user-can-create-other-user --policy-arn arn:aws:iam::345164961032:policy/OnlyCanCreateUser

# 我是谁？（这个操作很特殊，不需要权限，在策略中被显式拒绝了也能执行成功）
aws sts get-caller-identity

# 删除IAM用户
aws iam delete-user --user-name wuyingge

# 查看所有IAM用户
aws --no-paginate iam list-users

# 查看IAM用户名下的access key
aws iam list-access-keys --user-name user-can-create-other-user

# 更新access key的状态（启用或者禁用）
aws iam update-access-key --user-name user-can-create-other-user --access-key-id AKIAVAXLPKUEKAG6NYWR  --status Inactive

# 删除某一个access key
aws iam delete-access-key --user-name user-can-create-other-user --access-key-id AKIAVAXLPKUENLN2GGFC

# 修改自己的密码（只能是IAM用户）
aws iam change-password --old-password 'wGysGSLnek3sYny' --new-password 'YDZwF&E_8gfqht2w+'