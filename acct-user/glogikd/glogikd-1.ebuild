# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="user for app-misc/GLogiK"
ACCT_USER_ID="-1"
ACCT_USER_GROUPS=( glogikd )

acct-user_add_deps
