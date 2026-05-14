SET QUOTED_IDENTIFIER OFF;
GO
USE [IsTakipDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Isler_Durumlar]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Isler] DROP CONSTRAINT [FK_Isler_Durumlar];
GO
IF OBJECT_ID(N'[dbo].[FK_Isler_Personeller]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Isler] DROP CONSTRAINT [FK_Isler_Personeller];
GO
IF OBJECT_ID(N'[dbo].[FK_Personeller_Birimler]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Personeller] DROP CONSTRAINT [FK_Personeller_Birimler];
GO
IF OBJECT_ID(N'[dbo].[FK_Personeller_YetkiTurler]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Personeller] DROP CONSTRAINT [FK_Personeller_YetkiTurler];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Birimler]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Birimler];
GO
IF OBJECT_ID(N'[dbo].[Durumlar]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Durumlar];
GO
IF OBJECT_ID(N'[dbo].[Isler]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Isler];
GO
IF OBJECT_ID(N'[dbo].[Personeller]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Personeller];
GO
IF OBJECT_ID(N'[dbo].[sysdiagrams]', 'U') IS NOT NULL
    DROP TABLE [dbo].[sysdiagrams];
GO
IF OBJECT_ID(N'[dbo].[YetkiTurler]', 'U') IS NOT NULL
    DROP TABLE [dbo].[YetkiTurler];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Birimler'
CREATE TABLE [dbo].[Birimler] (
    [birimId] int IDENTITY(1,1) NOT NULL,
    [birimAd] nvarchar(50)  NULL
);
GO

-- Creating table 'Durumlar'
CREATE TABLE [dbo].[Durumlar] (
    [durumId] int IDENTITY(1,1) NOT NULL,
    [durumAd] nvarchar(50)  NULL
);
GO

-- Creating table 'Personeller'
CREATE TABLE [dbo].[Personeller] (
    [personelId] int IDENTITY(1,1) NOT NULL,
    [personelAdSoyad] nvarchar(50)  NULL,
    [personelKullaniciAd] nvarchar(50)  NULL,
    [personelParola] nvarchar(50)  NULL,
    [personelBirimId] int  NULL,
    [personelYetkiTurId] int  NULL
);
GO

-- Creating table 'sysdiagrams'
CREATE TABLE [dbo].[sysdiagrams] (
    [name] nvarchar(128)  NOT NULL,
    [principal_id] int  NOT NULL,
    [diagram_id] int IDENTITY(1,1) NOT NULL,
    [version] int  NULL,
    [definition] varbinary(max)  NULL
);
GO

-- Creating table 'YetkiTurler'
CREATE TABLE [dbo].[YetkiTurler] (
    [yetkiTurId] int IDENTITY(1,1) NOT NULL,
    [yetkiTurAd] nvarchar(50)  NULL
);
GO

-- Creating table 'Isler'
CREATE TABLE [dbo].[Isler] (
    [isId] int IDENTITY(1,1) NOT NULL,
    [isBaslik] nvarchar(max)  NULL,
    [isAciklama] nvarchar(max)  NULL,
    [isPersonelId] int  NULL,
    [iletilenTarih] datetime  NULL,
    [yapilanTarih] datetime  NULL,
    [isDurumId] int  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [birimId] in table 'Birimler'
ALTER TABLE [dbo].[Birimler]
ADD CONSTRAINT [PK_Birimler]
    PRIMARY KEY CLUSTERED ([birimId] ASC);
GO

-- Creating primary key on [durumId] in table 'Durumlar'
ALTER TABLE [dbo].[Durumlar]
ADD CONSTRAINT [PK_Durumlar]
    PRIMARY KEY CLUSTERED ([durumId] ASC);
GO

-- Creating primary key on [personelId] in table 'Personeller'
ALTER TABLE [dbo].[Personeller]
ADD CONSTRAINT [PK_Personeller]
    PRIMARY KEY CLUSTERED ([personelId] ASC);
GO

-- Creating primary key on [diagram_id] in table 'sysdiagrams'
ALTER TABLE [dbo].[sysdiagrams]
ADD CONSTRAINT [PK_sysdiagrams]
    PRIMARY KEY CLUSTERED ([diagram_id] ASC);
GO

-- Creating primary key on [yetkiTurId] in table 'YetkiTurler'
ALTER TABLE [dbo].[YetkiTurler]
ADD CONSTRAINT [PK_YetkiTurler]
    PRIMARY KEY CLUSTERED ([yetkiTurId] ASC);
GO

-- Creating primary key on [isId] in table 'Isler'
ALTER TABLE [dbo].[Isler]
ADD CONSTRAINT [PK_Isler]
    PRIMARY KEY CLUSTERED ([isId] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [personelBirimId] in table 'Personeller'
ALTER TABLE [dbo].[Personeller]
ADD CONSTRAINT [FK_Personeller_Birimler]
    FOREIGN KEY ([personelBirimId])
    REFERENCES [dbo].[Birimler]
        ([birimId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Personeller_Birimler'
CREATE INDEX [IX_FK_Personeller_Birimler]
ON [dbo].[Personeller]
    ([personelBirimId]);
GO

-- Creating foreign key on [personelYetkiTurId] in table 'Personeller'
ALTER TABLE [dbo].[Personeller]
ADD CONSTRAINT [FK_Personeller_YetkiTurler]
    FOREIGN KEY ([personelYetkiTurId])
    REFERENCES [dbo].[YetkiTurler]
        ([yetkiTurId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Personeller_YetkiTurler'
CREATE INDEX [IX_FK_Personeller_YetkiTurler]
ON [dbo].[Personeller]
    ([personelYetkiTurId]);
GO

-- Creating foreign key on [isDurumId] in table 'Isler'
ALTER TABLE [dbo].[Isler]
ADD CONSTRAINT [FK_Isler_Durumlar]
    FOREIGN KEY ([isDurumId])
    REFERENCES [dbo].[Durumlar]
        ([durumId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Isler_Durumlar'
CREATE INDEX [IX_FK_Isler_Durumlar]
ON [dbo].[Isler]
    ([isDurumId]);
GO

-- Creating foreign key on [isPersonelId] in table 'Isler'
ALTER TABLE [dbo].[Isler]
ADD CONSTRAINT [FK_Isler_Personeller]
    FOREIGN KEY ([isPersonelId])
    REFERENCES [dbo].[Personeller]
        ([personelId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Isler_Personeller'
CREATE INDEX [IX_FK_Isler_Personeller]
ON [dbo].[Isler]
    ([isPersonelId]);
GO

-- --------------------------------------------------
-- Inserting sample data
-- --------------------------------------------------

-- Insert YetkiTurler (User Roles)
INSERT INTO [dbo].[YetkiTurler] ([yetkiTurAd]) VALUES (N'Yönetici');
INSERT INTO [dbo].[YetkiTurler] ([yetkiTurAd]) VALUES (N'Çalışan');
GO

-- Insert Birimler (Departments)
INSERT INTO [dbo].[Birimler] ([birimAd]) VALUES (N'İnsan Kaynakları');
INSERT INTO [dbo].[Birimler] ([birimAd]) VALUES (N'Bilgi İşlem');
INSERT INTO [dbo].[Birimler] ([birimAd]) VALUES (N'Satış');
INSERT INTO [dbo].[Birimler] ([birimAd]) VALUES (N'Muhasebe');
GO

-- Insert Durumlar (Job Status)
INSERT INTO [dbo].[Durumlar] ([durumAd]) VALUES (N'Yapılmadı');
INSERT INTO [dbo].[Durumlar] ([durumAd]) VALUES (N'Yapılıyor');
INSERT INTO [dbo].[Durumlar] ([durumAd]) VALUES (N'Tamamlandı');
INSERT INTO [dbo].[Durumlar] ([durumAd]) VALUES (N'İptal Edildi');
GO

-- Insert Personeller (Employees)
INSERT INTO [dbo].[Personeller] ([personelAdSoyad], [personelKullaniciAd], [personelParola], [personelBirimId], [personelYetkiTurId])
VALUES (N'Admin Kullanıcı', N'admin', N'123456', 2, 1);
GO
INSERT INTO [dbo].[Personeller] ([personelAdSoyad], [personelKullaniciAd], [personelParola], [personelBirimId], [personelYetkiTurId])
VALUES (N'Ahmet Yılmaz', N'ahmet', N'123456', 1, 2);
GO
INSERT INTO [dbo].[Personeller] ([personelAdSoyad], [personelKullaniciAd], [personelParola], [personelBirimId], [personelYetkiTurId])
VALUES (N'Fatma Şahin', N'fatma', N'123456', 2, 2);
GO
INSERT INTO [dbo].[Personeller] ([personelAdSoyad], [personelKullaniciAd], [personelParola], [personelBirimId], [personelYetkiTurId])
VALUES (N'Mehmet Kaya', N'mehmet', N'123456', 3, 2);
GO

-- Insert sample Isler (Jobs/Tasks)
INSERT INTO [dbo].[Isler] ([isBaslik], [isAciklama], [isPersonelId], [iletilenTarih], [isDurumId])
VALUES (N'Müşteri Raporu Hazırlama', N'Aylık müşteri analiz raporunun hazırlanması', 2, '2026-05-10 09:00:00', 2);
GO
INSERT INTO [dbo].[Isler] ([isBaslik], [isAciklama], [isPersonelId], [iletilenTarih], [isDurumId])
VALUES (N'Sistem Bakımı', N'Sunucu güncellemeleri ve sistem kontrolleri', 3, '2026-05-11 10:30:00', 1);
GO
INSERT INTO [dbo].[Isler] ([isBaslik], [isAciklama], [isPersonelId], [iletilenTarih], [isDurumId])
VALUES (N'Satış Toplantısı Hazırlığı', N'Aylık satış toplantısı için sunum hazırlanması', 4, '2026-05-12 14:00:00', 1);
GO

-- Script has ended
