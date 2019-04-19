USE [TodoAppDb]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Todo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Text] [varchar](2000) NOT NULL,
	[IsCompleted] [bit] NOT NULL,
 CONSTRAINT [Pk_Todo] PRIMARY KEY CLUSTERED  
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TodoLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](1000) NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[TodoId] [int] NOT NULL,
 CONSTRAINT [Pk_TodoLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Todo] ON 

INSERT [dbo].[Todo] ([Id], [Text], [IsCompleted]) VALUES (3, 'Comprar Pão', 0)
INSERT [dbo].[Todo] ([Id], [Text], [IsCompleted]) VALUES (4, 'Comprar ração do cachorro', 0)
SET IDENTITY_INSERT [dbo].[Todo] OFF
SET IDENTITY_INSERT [dbo].[TodoLog] ON 

INSERT [dbo].[TodoLog] ([Id], [Description], [CreationTime], [TodoId]) VALUES (2, N'Inclusão de nova todo', CAST(N'2019-04-19T11:49:34.213' AS DateTime), 3)
INSERT [dbo].[TodoLog] ([Id], [Description], [CreationTime], [TodoId]) VALUES (3, N'Inclusão de nova todo', CAST(N'2019-04-19T11:52:03.553' AS DateTime), 4)
SET IDENTITY_INSERT [dbo].[TodoLog] OFF
ALTER TABLE [dbo].[TodoLog]  WITH CHECK ADD  CONSTRAINT [Fk_TodoLog_Todo] FOREIGN KEY([TodoId])
REFERENCES [dbo].[Todo] ([Id])
GO
ALTER TABLE [dbo].[TodoLog] CHECK CONSTRAINT [Fk_TodoLog_Todo]
GO


create procedure [dbo].[todo_sp_create]
@Text varchar(255),
@IsCompleted bit

as 
begin
set nocount on;
insert into todo (text, iscompleted)
output inserted.Id
values (@Text, @IsCompleted)
end

GO
create procedure [dbo].[todo_sp_delete]
@Id int = null

as 
begin
delete from todo
where 
ID = @id

end


GO

create procedure [dbo].[todo_sp_get]
@Id int = null

as 
begin
select ID, text, iscompleted from todo
where 
ID = @id

end


GO

create procedure [dbo].[todo_sp_list]
@Id int = null,
@Text varchar(255) = null,
@IsCompleted bit = null

as 
begin
select ID, text, iscompleted from todo
where 
ID = ISNULL(@Id, ID) and
TEXT = ISNULL(@Text, text) and
Iscompleted = ISNULL(@IsCompleted, iscompleted)
end


GO

create procedure [dbo].[todo_sp_update]
@Id int,
@Text varchar(255),
@IsCompleted bit

as 
begin
update todo set
[Text] = @Text,
[Iscompleted] = @IsCompleted
where [Id] = @Id
end
