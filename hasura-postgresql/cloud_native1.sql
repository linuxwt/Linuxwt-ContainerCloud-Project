/*
 Navicat Premium Data Transfer

 Source Server         : localhost-pgsql
 Source Server Type    : PostgreSQL
 Source Server Version : 120009
 Source Host           : localhost:5431
 Source Catalog        : Test
 Source Schema         : cloud_native

 Target Server Type    : PostgreSQL
 Target Server Version : 120009
 File Encoding         : 65001

 Date: 08/06/2022 10:37:29
*/


-- ----------------------------
-- Table structure for group_role_mapping
-- ----------------------------
DROP TABLE IF EXISTS "cloud_native"."group_role_mapping";
CREATE TABLE "cloud_native"."group_role_mapping" (
  "role_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "group_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "id" uuid NOT NULL DEFAULT uuid_generate_v4()
)
;
COMMENT ON COLUMN "cloud_native"."group_role_mapping"."role_id" IS '角色UUID';
COMMENT ON COLUMN "cloud_native"."group_role_mapping"."group_id" IS '组UUID';
COMMENT ON TABLE "cloud_native"."group_role_mapping" IS '组角色映射表';

-- ----------------------------
-- Table structure for role_permission_mapping
-- ----------------------------
DROP TABLE IF EXISTS "cloud_native"."role_permission_mapping";
CREATE TABLE "cloud_native"."role_permission_mapping" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "permission_id" uuid,
  "role_id" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON TABLE "cloud_native"."role_permission_mapping" IS '角色和权限的关系映射表';

-- ----------------------------
-- Table structure for tb_group
-- ----------------------------
DROP TABLE IF EXISTS "cloud_native"."tb_group";
CREATE TABLE "cloud_native"."tb_group" (
  "id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "parent_id" varchar(36) COLLATE "pg_catalog"."default",
  "manager" varchar(36) COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "created_by" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_at" timestamptz(6) DEFAULT now(),
  "updated_by" varchar(128) COLLATE "pg_catalog"."default",
  "level" int4 NOT NULL DEFAULT 1
)
;
COMMENT ON COLUMN "cloud_native"."tb_group"."id" IS '组UUID，和Keycloak中保持一致';
COMMENT ON COLUMN "cloud_native"."tb_group"."name" IS '组名称，和Keycloak中保持一致';
COMMENT ON COLUMN "cloud_native"."tb_group"."parent_id" IS '父组ID';
COMMENT ON COLUMN "cloud_native"."tb_group"."manager" IS '管理员UUID';
COMMENT ON COLUMN "cloud_native"."tb_group"."created_at" IS '组创建时间';
COMMENT ON COLUMN "cloud_native"."tb_group"."created_by" IS '组创建人';
COMMENT ON COLUMN "cloud_native"."tb_group"."updated_at" IS '组修改时间';
COMMENT ON COLUMN "cloud_native"."tb_group"."updated_by" IS '组修改人';
COMMENT ON COLUMN "cloud_native"."tb_group"."level" IS '层级';
COMMENT ON TABLE "cloud_native"."tb_group" IS '组';

-- ----------------------------
-- Table structure for tb_permission
-- ----------------------------
DROP TABLE IF EXISTS "cloud_native"."tb_permission";
CREATE TABLE "cloud_native"."tb_permission" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'directory'::bpchar,
  "path" varchar(255) COLLATE "pg_catalog"."default",
  "component" varchar(255) COLLATE "pg_catalog"."default",
  "permission_key" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "status" bool NOT NULL DEFAULT true,
  "level" int4 NOT NULL DEFAULT 1,
  "parent_id" varchar(255) COLLATE "pg_catalog"."default",
  "sort" int4 NOT NULL DEFAULT 0,
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "en_name" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "cloud_native"."tb_permission"."id" IS '执行sql语句 create extension "uuid-ossp"';
COMMENT ON TABLE "cloud_native"."tb_permission" IS '菜单、按钮权限表';

-- ----------------------------
-- Table structure for tb_role
-- ----------------------------
DROP TABLE IF EXISTS "cloud_native"."tb_role";
CREATE TABLE "cloud_native"."tb_role" (
  "id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "created_by" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_at" timestamptz(6) DEFAULT now(),
  "updated_by" varchar(128) COLLATE "pg_catalog"."default",
  "remark" text COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "cloud_native"."tb_role"."id" IS '角色UUID，和Keycloak中保持一致';
COMMENT ON COLUMN "cloud_native"."tb_role"."name" IS '角色名称，和Keycloak中保持一致';
COMMENT ON COLUMN "cloud_native"."tb_role"."created_at" IS '角色创建时间';
COMMENT ON COLUMN "cloud_native"."tb_role"."created_by" IS '角色创建人';
COMMENT ON COLUMN "cloud_native"."tb_role"."updated_at" IS '角色修改时间';
COMMENT ON COLUMN "cloud_native"."tb_role"."updated_by" IS '角色修改人';
COMMENT ON COLUMN "cloud_native"."tb_role"."remark" IS '备注';
COMMENT ON TABLE "cloud_native"."tb_role" IS '角色表';

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS "cloud_native"."tb_user";
CREATE TABLE "cloud_native"."tb_user" (
  "id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "sex" varchar(8) COLLATE "pg_catalog"."default",
  "mobile" varchar(16) COLLATE "pg_catalog"."default",
  "mobile_verified" bool,
  "created_by" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_at" timestamptz(6) DEFAULT now(),
  "updated_by" varchar(128) COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) DEFAULT now(),
  "email" varchar(36) COLLATE "pg_catalog"."default",
  "email_verified" bool,
  "status" bool NOT NULL DEFAULT true
)
;
COMMENT ON COLUMN "cloud_native"."tb_user"."id" IS '用户UUID，和Keycloak中保持一致';
COMMENT ON COLUMN "cloud_native"."tb_user"."name" IS '用户名称，和Keycloak中保持一致';
COMMENT ON COLUMN "cloud_native"."tb_user"."sex" IS '性别，"Male" or "Female"';
COMMENT ON COLUMN "cloud_native"."tb_user"."mobile" IS '手机号';
COMMENT ON COLUMN "cloud_native"."tb_user"."mobile_verified" IS '手机号是否确认有效';
COMMENT ON COLUMN "cloud_native"."tb_user"."created_by" IS '用户创建人';
COMMENT ON COLUMN "cloud_native"."tb_user"."updated_at" IS '用户修改时间';
COMMENT ON COLUMN "cloud_native"."tb_user"."updated_by" IS '用户修改人';
COMMENT ON COLUMN "cloud_native"."tb_user"."created_at" IS '用户创建时间';
COMMENT ON COLUMN "cloud_native"."tb_user"."email" IS '邮箱';
COMMENT ON COLUMN "cloud_native"."tb_user"."email_verified" IS '邮箱有效性';
COMMENT ON TABLE "cloud_native"."tb_user" IS '用户信息表';

-- ----------------------------
-- Table structure for user_group_membership
-- ----------------------------
DROP TABLE IF EXISTS "cloud_native"."user_group_membership";
CREATE TABLE "cloud_native"."user_group_membership" (
  "user_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "group_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "id" uuid NOT NULL DEFAULT uuid_generate_v4()
)
;
COMMENT ON COLUMN "cloud_native"."user_group_membership"."user_id" IS '用户UUID';
COMMENT ON COLUMN "cloud_native"."user_group_membership"."group_id" IS '组UUID';
COMMENT ON TABLE "cloud_native"."user_group_membership" IS '组用户成员映射表';

-- ----------------------------
-- Table structure for user_role_mapping
-- ----------------------------
DROP TABLE IF EXISTS "cloud_native"."user_role_mapping";
CREATE TABLE "cloud_native"."user_role_mapping" (
  "role_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "user_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "id" uuid NOT NULL DEFAULT uuid_generate_v4()
)
;
COMMENT ON COLUMN "cloud_native"."user_role_mapping"."role_id" IS '角色UUID';
COMMENT ON COLUMN "cloud_native"."user_role_mapping"."user_id" IS '用户UUID';
COMMENT ON TABLE "cloud_native"."user_role_mapping" IS '用户角色映射表';

-- ----------------------------
-- Uniques structure for table group_role_mapping
-- ----------------------------
ALTER TABLE "cloud_native"."group_role_mapping" ADD CONSTRAINT "group_role_mapping_group_id_role_id_key" UNIQUE ("group_id", "role_id");

-- ----------------------------
-- Primary Key structure for table group_role_mapping
-- ----------------------------
ALTER TABLE "cloud_native"."group_role_mapping" ADD CONSTRAINT "group_role_mapping_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table role_permission_mapping
-- ----------------------------
ALTER TABLE "cloud_native"."role_permission_mapping" ADD CONSTRAINT "role_permission_mapping_permission_id_role_id_key" UNIQUE ("permission_id", "role_id");

-- ----------------------------
-- Primary Key structure for table role_permission_mapping
-- ----------------------------
ALTER TABLE "cloud_native"."role_permission_mapping" ADD CONSTRAINT "role_permission_mapping_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table tb_group
-- ----------------------------
ALTER TABLE "cloud_native"."tb_group" ADD CONSTRAINT "tb_group_name_parent_id_key" UNIQUE ("name", "parent_id");

-- ----------------------------
-- Primary Key structure for table tb_group
-- ----------------------------
ALTER TABLE "cloud_native"."tb_group" ADD CONSTRAINT "tb_group_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table tb_permission
-- ----------------------------
ALTER TABLE "cloud_native"."tb_permission" ADD CONSTRAINT "tb_permission_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table tb_role
-- ----------------------------
ALTER TABLE "cloud_native"."tb_role" ADD CONSTRAINT "tb_role_name_key" UNIQUE ("name");

-- ----------------------------
-- Primary Key structure for table tb_role
-- ----------------------------
ALTER TABLE "cloud_native"."tb_role" ADD CONSTRAINT "tb_role_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table tb_user
-- ----------------------------
ALTER TABLE "cloud_native"."tb_user" ADD CONSTRAINT "tb_user_name_key" UNIQUE ("name");

-- ----------------------------
-- Primary Key structure for table tb_user
-- ----------------------------
ALTER TABLE "cloud_native"."tb_user" ADD CONSTRAINT "tb_user_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table user_group_membership
-- ----------------------------
ALTER TABLE "cloud_native"."user_group_membership" ADD CONSTRAINT "user_group_membership_user_id_group_id_key" UNIQUE ("user_id", "group_id");

-- ----------------------------
-- Primary Key structure for table user_group_membership
-- ----------------------------
ALTER TABLE "cloud_native"."user_group_membership" ADD CONSTRAINT "user_group_membership_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table user_role_mapping
-- ----------------------------
ALTER TABLE "cloud_native"."user_role_mapping" ADD CONSTRAINT "user_role_mapping_role_id_user_id_key" UNIQUE ("role_id", "user_id");

-- ----------------------------
-- Primary Key structure for table user_role_mapping
-- ----------------------------
ALTER TABLE "cloud_native"."user_role_mapping" ADD CONSTRAINT "user_role_mapping_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table group_role_mapping
-- ----------------------------
ALTER TABLE "cloud_native"."group_role_mapping" ADD CONSTRAINT "group_role_mapping_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "cloud_native"."tb_group" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "cloud_native"."group_role_mapping" ADD CONSTRAINT "group_role_mapping_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "cloud_native"."tb_role" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table role_permission_mapping
-- ----------------------------
ALTER TABLE "cloud_native"."role_permission_mapping" ADD CONSTRAINT "role_permission_mapping_permission_id_fkey" FOREIGN KEY ("permission_id") REFERENCES "cloud_native"."tb_permission" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "cloud_native"."role_permission_mapping" ADD CONSTRAINT "role_permission_mapping_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "cloud_native"."tb_role" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table user_group_membership
-- ----------------------------
ALTER TABLE "cloud_native"."user_group_membership" ADD CONSTRAINT "user_group_membership_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "cloud_native"."tb_group" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "cloud_native"."user_group_membership" ADD CONSTRAINT "user_group_membership_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "cloud_native"."tb_user" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table user_role_mapping
-- ----------------------------
ALTER TABLE "cloud_native"."user_role_mapping" ADD CONSTRAINT "user_role_mapping_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "cloud_native"."tb_role" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "cloud_native"."user_role_mapping" ADD CONSTRAINT "user_role_mapping_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "cloud_native"."tb_user" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;
