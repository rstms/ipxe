
#define BANNER_TIMEOUT		20

#define	NET_PROTO_IPV4		/* IPv4 protocol */
#undef	NET_PROTO_IPV6		/* IPv6 protocol */
#undef	NET_PROTO_FCOE		/* Fibre Channel over Ethernet protocol */
#undef	NET_PROTO_STP		/* Spanning Tree protocol */
#undef	NET_PROTO_LACP		/* Link Aggregation control protocol */
#undef	NET_PROTO_EAPOL		/* EAP over LAN protocol */
#undef	NET_PROTO_LLDP		/* Link Layer Discovery protocol */

#undef	DOWNLOAD_PROTO_TFTP	/* Trivial File Transfer Protocol */
#define	DOWNLOAD_PROTO_HTTP	/* Hypertext Transfer Protocol */
#define	DOWNLOAD_PROTO_HTTPS	/* Secure Hypertext Transfer Protocol */
#undef	DOWNLOAD_PROTO_FTP	/* File Transfer Protocol */
#undef	DOWNLOAD_PROTO_SLAM	/* Scalable Local Area Multicast */
#undef	DOWNLOAD_PROTO_NFS	/* Network File System Protocol */
#undef	DOWNLOAD_PROTO_FILE	/* Local filesystem access */

#undef	SANBOOT_PROTO_ISCSI	/* iSCSI protocol */
#undef	SANBOOT_PROTO_AOE	/* AoE protocol */
#undef	SANBOOT_PROTO_IB_SRP	/* Infiniband SCSI RDMA protocol */
#undef	SANBOOT_PROTO_FCP	/* Fibre Channel protocol */
#define	SANBOOT_PROTO_HTTP	/* HTTP SAN protocol */

#undef	HTTP_AUTH_BASIC		/* Basic authentication */
#undef	HTTP_AUTH_DIGEST	/* Digest authentication */
#undef	HTTP_AUTH_NTLM		/* NTLM authentication */
#undef	HTTP_ENC_PEERDIST	/* PeerDist content encoding */
#undef	HTTP_HACK_GCE		/* Google Compute Engine hacks */

#undef	CRYPTO_80211_WEP	/* WEP encryption (deprecated and insecure!) */
#undef	CRYPTO_80211_WPA	/* WPA Personal, authenticating with passphrase */
#undef	CRYPTO_80211_WPA2	/* Add support for stronger WPA cryptography */

#undef	EAP_METHOD_MD5		/* MD5-Challenge port authentication */
#undef	EAP_METHOD_MSCHAPV2	/* MS-CHAPv2 port authentication */

#define	DNS_RESOLVER		/* DNS resolver */

#undef	IMAGE_NBI		/* NBI image support */
#define	IMAGE_ELF		/* ELF image support */
#undef	IMAGE_MULTIBOOT		/* MultiBoot image support */
#undef	IMAGE_PXE		/* PXE image support */
#define	IMAGE_SCRIPT		/* iPXE script image support */
#define	IMAGE_BZIMAGE		/* Linux bzImage image support */
#undef	IMAGE_COMBOOT		/* SYSLINUX COMBOOT image support */
#undef	IMAGE_EFI		/* EFI image support */
#undef	IMAGE_SDI		/* SDI image support */
#undef	IMAGE_PNM		/* PNM image support */
#define	IMAGE_PNG		/* PNG image support */
#undef	IMAGE_DER		/* DER image support */
#define	IMAGE_PEM		/* PEM image support */
#define	IMAGE_ZLIB		/* ZLIB image support */
#define	IMAGE_GZIP		/* GZIP image support */
#undef	IMAGE_UCODE		/* Microcode update image support */

#define	AUTOBOOT_CMD		/* Automatic booting */
#define	NVO_CMD			/* Non-volatile option storage commands */
#define	CONFIG_CMD		/* Option configuration console */
#undef	IFMGMT_CMD		/* Interface management commands */
#undef	IWMGMT_CMD		/* Wireless interface management commands */
#undef	IBMGMT_CMD		/* Infiniband management commands */
#undef	FCMGMT_CMD		/* Fibre Channel management commands */
#undef	ROUTE_CMD		/* Routing table management commands */
#define IMAGE_CMD		/* Image management commands */
#define DHCP_CMD		/* DHCP management commands */
#define SANBOOT_CMD		/* SAN boot commands */
#define MENU_CMD		/* Menu commands */
#undef	FORM_CMD		/* Form commands */
#undef	LOGIN_CMD		/* Login command */
#undef	SYNC_CMD		/* Sync command */
#define SHELL_CMD		/* Shell command */
#undef	NSLOOKUP_CMD		/* DNS resolving command */
#undef	TIME_CMD		/* Time commands */
#undef	DIGEST_CMD		/* Image crypto digest commands */
#undef	LOTEST_CMD		/* Loopback testing commands */
#undef	VLAN_CMD		/* VLAN commands */
#undef	PXE_CMD			/* PXE commands */
#define REBOOT_CMD		/* Reboot command */
#define POWEROFF_CMD		/* Power off command */
#undef	IMAGE_TRUST_CMD		/* Image trust management commands */
#undef	IMAGE_CRYPT_CMD		/* Image encryption management commands */
#undef	PCI_CMD			/* PCI commands */
#undef	PARAM_CMD		/* Request parameter commands */
#undef	NEIGHBOUR_CMD		/* Neighbour management commands */
#define PING_CMD		/* Ping command */
#define CONSOLE_CMD		/* Console command */
#undef	IPSTAT_CMD		/* IP statistics commands */
#undef	PROFSTAT_CMD		/* Profiling commands */
#define NTP_CMD			/* NTP commands */
#define CERT_CMD		/* Certificate management commands */
#undef	IMAGE_MEM_CMD		/* Read memory command */
#define IMAGE_ARCHIVE_CMD	/* Archive image management commands */
#undef	SHIM_CMD		/* EFI shim command (or dummy command) */

#define CONSOLE_FRAMEBUFFER
#undef	OCSP_CHECK
