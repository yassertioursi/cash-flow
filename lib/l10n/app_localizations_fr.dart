// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Cashflow';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get welcomeBack => 'Bon retour !';

  @override
  String helloUser(String name) {
    return 'Bonjour, $name 👋';
  }

  @override
  String get addTransaction => 'Ajouter une transaction';

  @override
  String get editTransaction => 'Modifier la transaction';

  @override
  String get filterTransactions => 'Filtrer les transactions';

  @override
  String get searchTransactions => 'Rechercher des transactions...';

  @override
  String get addFilters => 'Ajouter des filtres';

  @override
  String get dashboardTotalBalance => 'Solde total';

  @override
  String get dashboardMonthlySavings => 'Épargne mensuelle';

  @override
  String get dashboardWeeklyOverview => 'Aperçu hebdomadaire';

  @override
  String get dashboardRecentTransactions => 'Transactions récentes';

  @override
  String get dashboardNoTransactions => 'Aucune transaction disponible.';

  @override
  String get dashboardWeeklyOverviewInfo =>
      'Affiche un aperçu hebdomadaire des transactions.\nLa barre la plus à droite représente aujourd\'hui.';

  @override
  String get helpSubTitle => 'Obtenir de l\'aide et du support';

  @override
  String get feedbackSubTitle => 'Envoyez-nous vos commentaires';

  @override
  String get termsSubTitle => 'Lire nos conditions d\'utilisation';

  @override
  String get settingsSubTitle => 'Gérer les paramètres de l\'application';

  @override
  String get privacySubTitle => 'Consulter nos politiques de confidentialité';

  @override
  String get policySubTitle => 'Comprendre notre politique de confidentialité';

  @override
  String get passwordSubTitle => 'Modifier le mot de passe de votre compte';

  @override
  String get securitySubTitle => 'Renforcer la sécurité de votre compte';

  @override
  String get budgetInfoSubTitle => 'Consulter et gérer votre budget';

  @override
  String get manageDataSubTitle => 'Gérer vos préférences de données';

  @override
  String get personalInfoSubTitle =>
      'Mettre à jour vos informations personnelles';

  @override
  String get notificationsSubTitle => 'Gérer vos préférences de notifications';

  @override
  String get appearanceSubTitle =>
      'Personnaliser l\'apparence de l\'application';

  @override
  String get unsavedChangesTitle => 'Modifications non enregistrées';

  @override
  String get askForgotPassword => 'Mot de passe oublié ?';

  @override
  String get askAlreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get askDontHaveAccount => 'Vous n\'avez pas de compte ?';

  @override
  String get askConfirmDeleteData =>
      'Voulez-vous vraiment supprimer toutes vos données ? Cette action est irréversible.';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get confirmDeleteDataTitle => 'Confirmer la suppression des données';

  @override
  String get loginSignInToContinue =>
      'Connectez-vous pour continuer sur Cashflow';

  @override
  String get loginWelcomeMessage =>
      'Un suivi financier intelligent pour un avenir meilleur.';

  @override
  String get loginWarningTerms =>
      'En vous connectant, vous acceptez nos\nConditions d\'utilisation et notre Politique de confidentialité.';

  @override
  String get loginErrorGeneric => 'Échec de la connexion. Veuillez réessayer.';

  @override
  String get passwordRequirements => 'Exigences du mot de passe';

  @override
  String get pwRequirementNumber => 'Au moins un chiffre';

  @override
  String get pwRequirementLength => '8 caractères minimum';

  @override
  String get pwRequirementUppercase => 'Au moins une lettre majuscule';

  @override
  String get pwRequirementSpecial => 'Au moins un caractère spécial';

  @override
  String get btnApply => 'Appliquer';

  @override
  String get btnClear => 'Effacer';

  @override
  String get btnUndo => 'Annuler';

  @override
  String get btnRedo => 'Rétablir';

  @override
  String get btnCancel => 'Annuler';

  @override
  String get btnViewAll => 'Tout voir';

  @override
  String get btnSave => 'Enregistrer la transaction';

  @override
  String get btnDiscardChanges => 'Abandonner les modifications';

  @override
  String get btnSendTestNotification => 'Envoyer une notification de test';

  @override
  String get lbOr => 'Ou';

  @override
  String get lbTo => 'À :';

  @override
  String get lbFrom => 'De :';

  @override
  String get lbAll => 'Tout';

  @override
  String get lbName => 'Nom';

  @override
  String get lbDate => 'Date';

  @override
  String get lbHome => 'Accueil';

  @override
  String get lbFood => 'Alimentation';

  @override
  String get lbType => 'Type';

  @override
  String get lbBills => 'Factures';

  @override
  String get lbEmail => 'E-mail';

  @override
  String get lbPhone => 'Téléphone';

  @override
  String get lbTheme => 'Thème';

  @override
  String get lbWallet => 'Portefeuille';

  @override
  String get lbCancel => 'Annuler';

  @override
  String get lbIncome => 'Revenu';

  @override
  String get lbSalary => 'Salaire';

  @override
  String get lbSignIn => 'Se connecter';

  @override
  String get lbSignUp => 'S\'inscrire';

  @override
  String get lbHealth => 'Santé';

  @override
  String get lbOthers => 'Autres';

  @override
  String get lbAmount => 'Montant';

  @override
  String get lbDelete => 'Supprimer';

  @override
  String get lbImport => 'Importer';

  @override
  String get lbExport => 'Exporter';

  @override
  String get lbLogout => 'Se déconnecter';

  @override
  String get lbSupport => 'Support';

  @override
  String get lbReserve => 'Réserve';

  @override
  String get lbProfile => 'Profil';

  @override
  String get lbExpense => 'Dépense';

  @override
  String get lbAccount => 'Compte';

  @override
  String get lbAddress => 'Adresse';

  @override
  String get lbDismiss => 'Fermer';

  @override
  String get lbSettings => 'Paramètres';

  @override
  String get lbSecurity => 'Sécurité';

  @override
  String get lbShopping => 'Shopping';

  @override
  String get lbCategory => 'Catégorie';

  @override
  String get lbPassword => 'Mot de passe';

  @override
  String get lbFontSize => 'Taille de police';

  @override
  String get lbFullName => 'Nom complet';

  @override
  String get lbEncrypted => 'Chiffré';

  @override
  String get lbFrequency => 'Fréquence';

  @override
  String get lbAnalytics => 'Statistiques';

  @override
  String get lbTransport => 'Transport';

  @override
  String get lbAppearance => 'Apparence';

  @override
  String get lbAnimations => 'Animations';

  @override
  String get lbHideValues => 'Masquer les montants';

  @override
  String get lbLimitAlert => 'Alerte de limite';

  @override
  String get lbQuietHours => 'Heures calmes';

  @override
  String get lbBudgetInfo => 'Infos budget';

  @override
  String get lbManageData => 'Gérer les données';

  @override
  String get lbExportData => 'Exporter les données';

  @override
  String get lbDeleteData => 'Supprimer les données';

  @override
  String get lbHelpCenter => 'Centre d\'aide';

  @override
  String get lbDateBirth => 'Date de naissance';

  @override
  String get lbPreferences => 'Préférences';

  @override
  String get lbEnableCloud => 'Activer le cloud';

  @override
  String get lbAboutLegal => 'À propos & mentions légales';

  @override
  String get lbNewPassword => 'Nouveau mot de passe';

  @override
  String get lbBudgetLimit => 'Limite budgétaire';

  @override
  String get lbPersonalInfo => 'Infos personnelles';

  @override
  String get lbSendFeedback => 'Envoyer un retour';

  @override
  String get lbBackupData => 'Sauvegarde et restauration';

  @override
  String get lbNotifications => 'Notifications';

  @override
  String get lbUncategorized => 'Non catégorisé';

  @override
  String get lbEntertainment => 'Divertissement';

  @override
  String get lbEditThreshold => 'Modifier le seuil';

  @override
  String get lbPrivacyPolicy => 'Politique de confidentialité';

  @override
  String get lbBillsReminder => 'Rappel de factures';

  @override
  String get lbDailyReminder => 'Rappel quotidien';

  @override
  String get lbExpensesLimit => 'Limite de dépenses';

  @override
  String get lbMonthlyReport => 'Rapport mensuel';

  @override
  String get lbCreateAccount => 'Créer un compte';

  @override
  String get lbEcoFootprint => 'Empreinte carbone';

  @override
  String get lbChangePassword => 'Modifier le mot de passe';

  @override
  String get lbCurrencyFormat => 'Format de devise';

  @override
  String get lbColorBlindMode => 'Mode daltonisme';

  @override
  String get lbTermsOfService => 'Conditions d\'utilisation';

  @override
  String get lbMonthlyProgress => 'Progression mensuelle';

  @override
  String get lbAllTransactions => 'Toutes les transactions';

  @override
  String get lbCurrentPassword => 'Mot de passe actuel';

  @override
  String get lbConfirmPassword => 'Confirmer le mot de passe';

  @override
  String get lbSelectDateRange => 'Sélectionner une période';

  @override
  String get lbBiometrics => 'Authentification biométrique';

  @override
  String get lbEnergySavingTips => 'Conseils d\'économie d\'énergie';

  @override
  String get lbConfirmNewPassword => 'Confirmer le nouveau mot de passe';

  @override
  String get lbInitialDayOfMonth => 'Jour initial du mois';

  @override
  String get lbHighConsumptionAlert => 'Alerte de forte consommation';

  @override
  String get lbCreateAccountSubtitle => 'Inscrivez-vous pour commencer !';

  @override
  String get lbAgreeTerms =>
      'J\'accepte les conditions d\'utilisation et la politique de confidentialité.';

  @override
  String get msgTestNotificationSent => 'Notification de test envoyée !';

  @override
  String get msgFeatureComingSoon => 'Cette fonctionnalité arrive bientôt !';

  @override
  String get msgTransactionAdded => 'Transaction ajoutée avec succès.';

  @override
  String get msgTransactionUpdated => 'Transaction mise à jour avec succès.';

  @override
  String get msgTransactionDeleted => 'Transaction supprimée avec succès.';

  @override
  String get msgUnsavedChanges =>
      'Vous avez des modifications non enregistrées.\nVoulez-vous vraiment les abandonner ?';

  @override
  String get hintDateBirth => 'JJ/MM/AAAA';

  @override
  String get hintEmail => 'Entrez votre e-mail';

  @override
  String get hintAddress => '<Ville>, <Région>, <Pays>';

  @override
  String get hintAddressFormat => '<Ville>, <Région>, <Pays>';

  @override
  String get hintCategory => 'Écrivez la catégorie';

  @override
  String get hintPassword => 'Entrez votre mot de passe';

  @override
  String get hintFullName => 'Entrez votre nom complet';

  @override
  String get hintPhoneNumber => '+33 (XX) XX XX XX XX';

  @override
  String get hintConfirmPassword => 'Confirmez votre mot de passe';

  @override
  String get hintTransactionName => 'Entrez le nom de la transaction';

  @override
  String get hintConsumptionThreshold => 'Entrez le seuil de consommation';

  @override
  String get sectionGeneral => 'Général';

  @override
  String get sectionDisplay => 'Affichage';

  @override
  String get sectionAccessibility => 'Accessibilité';

  @override
  String get sectionMonthly => 'Mensuel';

  @override
  String get sectionWeekly => 'Hebdomadaire';

  @override
  String get sectionDaily => 'Quotidien';

  @override
  String get sectionDataManagement => 'Gestion des données';

  @override
  String get sectionBackup => 'Sauvegarde';

  @override
  String get sectionReminders => 'Rappels';

  @override
  String get sectionReports => 'Rapports';

  @override
  String get sectionDoNotDisturb => 'Ne pas déranger';

  @override
  String get sectionEcoNotifications => 'Notifications éco';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get currencySymbol => 'Symbole (\$)';

  @override
  String get currencyCode => 'Code (USD)';

  @override
  String get colorBlindNone => 'Aucun';

  @override
  String get colorBlindProtanopia => 'Protanopie';

  @override
  String get colorBlindDeuteranopia => 'Deutéranopie';

  @override
  String get colorBlindTritanopia => 'Tritanopie';

  @override
  String get fontSizeSmall => 'Petite';

  @override
  String get fontSizeMedium => 'Moyenne';

  @override
  String get fontSizeLarge => 'Grande';

  @override
  String get expensesLimitDescription =>
      'Définissez une limite pour maîtriser vos dépenses mensuelles.';

  @override
  String get setMonthlyExpensesLimit =>
      'Définir la limite mensuelle des dépenses';

  @override
  String get limitAlertDescription =>
      'Recevez une alerte lorsque vous atteignez votre limite budgétaire.';

  @override
  String get exportDataDescription =>
      'Exportez vos données dans un fichier à des fins de sauvegarde.';

  @override
  String get importDataDescription =>
      'Importez des données à partir d\'un fichier exporté précédemment.';

  @override
  String get deleteDataDescription =>
      'Supprimez définitivement toutes vos données de l\'application.';

  @override
  String get frequencyNone => 'Aucun';

  @override
  String get frequencyDaily => 'Quotidien';

  @override
  String get frequencyWeekly => 'Hebdomadaire';

  @override
  String get frequencyMonthly => 'Mensuel';

  @override
  String get dailyReminderDescription =>
      'Recevez des notifications quotidiennes sur votre consommation d\'énergie';

  @override
  String get billsReminderDescription => 'Soyez notifié des factures à venir';

  @override
  String get monthlyReportDescription =>
      'Recevez un résumé mensuel de consommation';

  @override
  String get energySavingTipsDescription =>
      'Recevez des conseils pour réduire votre consommation d\'énergie';

  @override
  String get highConsumptionAlertDescription =>
      'Alerte lorsque la consommation dépasse le seuil';

  @override
  String thresholdLabel(String value) {
    return 'Seuil : $value kWh';
  }

  @override
  String get ntfAlertConsumptionTitle => 'Alerte de consommation ! ⚠️';

  @override
  String ntfAlertConsumptionBody(String value) {
    return 'Vous avez dépassé votre limite de $value';
  }

  @override
  String get ntfTestTitle => 'Notification de test Cashflow';

  @override
  String get ntfTestBody => 'Ceci est une notification de test de Cashflow. 🌿';

  @override
  String get ntfBackupCompleteTitle => 'Sauvegarde terminée ✓';

  @override
  String get ntfBackupCompleteBody =>
      'Vos données ont été sauvegardées automatiquement.';

  @override
  String get ntfDailyReminderTitle => 'Rappel Cashflow';

  @override
  String get ntfDailyReminderBody =>
      'N\'oubliez pas de noter vos dépenses aujourd\'hui ! 🌱';

  @override
  String get ntfDailyReminderChannelName => 'Rappels quotidiens';

  @override
  String get ntfDailyReminderChannelDescription =>
      'Notifie d\'enregistrer les dépenses quotidiennement';

  @override
  String get ntfMonthlyReportTitle => 'Rapport mensuel 📊';

  @override
  String get ntfMonthlyReportBody =>
      'Votre résumé de dépenses mensuelles est prêt. Ouvrez Cashflow pour le consulter !';

  @override
  String get ntfMonthlyReportChannelName => 'Rapports mensuels';

  @override
  String get ntfMonthlyReportChannelDescription =>
      'Notifications de résumé de consommation mensuelle';

  @override
  String get errorNameInvalid => 'Le nom est trop court.';

  @override
  String get errorDateInvalid => 'Format de date invalide.';

  @override
  String get errorEmpty => 'Ce champ ne peut pas être vide.';

  @override
  String get errorDateOutOfRange => 'Date hors limites.';

  @override
  String get errorEmailInvalid => 'Format d\'e-mail invalide.';

  @override
  String get errorPasswordWeak => 'Mot de passe trop faible.';

  @override
  String get errorAddressInvalid => 'Format d\'adresse invalide.';

  @override
  String get errorNumberPositive => 'Le nombre doit être positif.';

  @override
  String get errorPasswordTooShort => 'Mot de passe trop court.';

  @override
  String get errorPasswordMismatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get errorPhoneInvalid => 'Format de numéro de téléphone invalide.';

  @override
  String get errorAmountInvalid => 'Veuillez saisir un montant valide.';

  @override
  String get errorAgreeTerms =>
      'Vous devez accepter les conditions pour continuer.';

  @override
  String get errorUnknown =>
      'Une erreur inconnue s\'est produite.\nVeuillez réessayer.';

  @override
  String get errorAmountMustBePositive =>
      'Le montant doit être supérieur à zéro.';

  @override
  String get errorEnterCurrentPassword =>
      'Veuillez saisir votre mot de passe actuel.';

  @override
  String get errorPercentageInvalid =>
      'Veuillez saisir un pourcentage valide (0-100).';

  @override
  String get errorSameAsCurrentPassword =>
      'Le nouveau mot de passe ne peut pas être identique au mot de passe actuel.';

  @override
  String get errorAmountFormat =>
      'Format de nombre invalide. Utilisez uniquement des chiffres et un séparateur décimal.';

  @override
  String ecoFootprintValue(String value) {
    return '$value kg CO₂';
  }

  @override
  String get lbEcoFootprintCompensation => 'Compensation nécessaire :';

  @override
  String ecoFootprintCompensation(int count) {
    return '$count arbres 🌳';
  }

  @override
  String get feedbackTitle => 'Nous serions ravis de vous entendre !';

  @override
  String get feedbackDescription =>
      'Vos retours nous aident à améliorer Cashflow et à créer une meilleure expérience pour tous.';

  @override
  String get feedbackCategoryLabel => 'Catégorie';

  @override
  String get feedbackCategoryBug => 'Signaler un bug';

  @override
  String get feedbackCategorySuggestion => 'Suggestion';

  @override
  String get feedbackCategoryCompliment => 'Compliment';

  @override
  String get feedbackCategoryOther => 'Autre';

  @override
  String get feedbackMessageLabel => 'Votre message';

  @override
  String get feedbackMessageHint => 'Dites-nous ce que vous pensez...';

  @override
  String get feedbackEmailLabel => 'Votre e-mail (facultatif)';

  @override
  String get feedbackEmailHint => 'Pour les questions de suivi';

  @override
  String get feedbackSubmitButton => 'Envoyer le retour';

  @override
  String get feedbackThankYou => 'Merci pour votre retour !';

  @override
  String feedbackCharacterCount(int count) {
    return '$count/500 caractères';
  }

  @override
  String get helpFaqTitle => 'Questions fréquentes';

  @override
  String get helpSearchHint => 'Rechercher des sujets d\'aide...';

  @override
  String get helpFaqAddTransaction => 'Comment ajouter une transaction ?';

  @override
  String get helpFaqAddTransactionAnswer =>
      'Appuyez sur le bouton « + » de l\'écran d\'accueil, choisissez le type de transaction (revenu, dépense ou réserve), remplissez les informations et appuyez sur « Enregistrer ».';

  @override
  String get helpFaqEditDelete =>
      'Comment modifier ou supprimer une transaction ?';

  @override
  String get helpFaqEditDeleteAnswer =>
      'Faites glisser la transaction vers la gauche pour afficher les options de modification et de suppression, ou touchez la transaction pour ouvrir les détails et utiliser les boutons d\'action.';

  @override
  String get helpFaqCategories => 'Comment gérer les catégories ?';

  @override
  String get helpFaqCategoriesAnswer =>
      'Allez dans Paramètres > Gérer les données pour personnaliser vos catégories de transactions.';

  @override
  String get helpFaqBackup => 'Comment sauvegarder mes données ?';

  @override
  String get helpFaqBackupAnswer =>
      'Activez la sauvegarde cloud dans Paramètres > Gérer les données > section Sauvegarde. Vous pouvez également exporter vos données manuellement.';

  @override
  String get helpFaqLanguage => 'Comment changer la langue ?';

  @override
  String get helpFaqLanguageAnswer =>
      'L\'application suit les paramètres de langue de votre appareil. Modifiez la langue de votre appareil pour changer la langue de l\'application.';

  @override
  String get helpContactTitle => 'Contacter le support';

  @override
  String get helpContactDescription =>
      'Vous avez toujours besoin d\'aide ? Notre équipe de support est là pour vous.';

  @override
  String get helpContactEmail => 'Assistance par e-mail';

  @override
  String get helpContactChat => 'Chat en direct';

  @override
  String get helpVersion => 'Version de l\'application';

  @override
  String policyLastUpdated(String date) {
    return 'Dernière mise à jour : $date';
  }

  @override
  String get policyIntroTitle => 'Introduction';

  @override
  String get policyIntroContent =>
      'Cashflow s\'engage à protéger votre vie privée. Cette politique explique comment nous collectons, utilisons et protégeons vos informations personnelles.';

  @override
  String get policyDataCollectionTitle => 'Collecte de données';

  @override
  String get policyDataCollectionContent =>
      'Nous collectons les informations que vous fournissez directement, telles que votre nom, votre e-mail et vos données de transactions financières. Toutes les données sont stockées de manière sécurisée sur votre appareil et, en option, dans un stockage cloud chiffré.';

  @override
  String get policyDataUsageTitle => 'Utilisation de vos données';

  @override
  String get policyDataUsageContent =>
      'Vos données servent uniquement à fournir les fonctionnalités de l\'application, notamment le suivi des transactions, la gestion du budget et la génération de rapports financiers. Nous ne vendons jamais vos données à des tiers.';

  @override
  String get policySecurityTitle => 'Sécurité des données';

  @override
  String get policySecurityContent =>
      'Nous mettons en œuvre des mesures de sécurité conformes aux normes du secteur, notamment le chiffrement, la transmission sécurisée des données et des audits de sécurité réguliers pour protéger vos informations.';

  @override
  String get policyRightsTitle => 'Vos droits';

  @override
  String get policyRightsContent =>
      'Vous avez le droit d\'accéder à vos données, de les modifier, de les exporter ou de les supprimer à tout moment via les paramètres de l\'application. Vous pouvez également demander une suppression complète de vos données en contactant notre équipe de support.';

  @override
  String get policyContactTitle => 'Contactez-nous';

  @override
  String get policyContactContent =>
      'Pour toute question concernant cette politique de confidentialité, contactez-nous à privacy@cashflow.app';

  @override
  String termsLastUpdated(String date) {
    return 'Dernière mise à jour : $date';
  }

  @override
  String get termsAcceptanceTitle => 'Acceptation des conditions';

  @override
  String get termsAcceptanceContent =>
      'En téléchargeant, installant ou utilisant Cashflow, vous acceptez d\'être lié par ces Conditions d\'utilisation. Si vous n\'êtes pas d\'accord, veuillez ne pas utiliser l\'application.';

  @override
  String get termsServiceTitle => 'Description du service';

  @override
  String get termsServiceContent =>
      'Cashflow fournit des outils de gestion financière personnelle, notamment le suivi des transactions, la budgétisation et l\'analyse financière. Le service est fourni « tel quel » pour un usage personnel et non commercial.';

  @override
  String get termsAccountTitle => 'Comptes utilisateurs';

  @override
  String get termsAccountContent =>
      'Vous êtes responsable du maintien de la confidentialité de vos identifiants de compte et de toutes les activités effectuées sous votre compte. Vous devez fournir des informations exactes et complètes lors de la création d\'un compte.';

  @override
  String get termsContentTitle => 'Contenu utilisateur';

  @override
  String get termsContentContent =>
      'Vous conservez tous les droits sur les données financières que vous saisissez dans l\'application. En utilisant nos fonctionnalités de sauvegarde cloud, vous nous autorisez à stocker et à traiter ces données uniquement pour fournir le service.';

  @override
  String get termsProhibitedTitle => 'Utilisations interdites';

  @override
  String get termsProhibitedContent =>
      'Vous ne devez pas utiliser Cashflow à des fins illégales, pour transmettre du code malveillant ou pour tenter d\'accéder aux données d\'autres utilisateurs. Toute violation peut entraîner la résiliation du compte.';

  @override
  String get termsLiabilityTitle => 'Limitation de responsabilité';

  @override
  String get termsLiabilityContent =>
      'Cashflow n\'est pas responsable des décisions financières que vous prenez sur la base des données ou des analyses de l\'application. Consultez toujours un professionnel financier pour les questions importantes.';

  @override
  String get termsChangesTitle => 'Modifications des conditions';

  @override
  String get termsChangesContent =>
      'Nous pouvons mettre à jour ces conditions périodiquement. L\'utilisation continue de l\'application après des modifications constitue une acceptation des nouvelles conditions.';

  @override
  String get exportDialogDescription =>
      'Exportez vos données pour créer une sauvegarde. Choisissez de chiffrer la sauvegarde avec un mot de passe.';

  @override
  String get hintEncryptedBackup =>
      'Protégez votre sauvegarde avec un mot de passe';

  @override
  String get passwordWarning =>
      'Avertissement : si vous oubliez ce mot de passe, vous ne pourrez pas récupérer vos données.';

  @override
  String get importDialogDescription =>
      'Sélectionnez la façon de gérer les données importées.';

  @override
  String get importModeTitle => 'Mode d\'importation';

  @override
  String get importModeMerge => 'Fusionner';

  @override
  String get importModeMergeHint =>
      'Ajouter de nouvelles données, ignorer les doublons';

  @override
  String get importModeReplace => 'Remplacer';

  @override
  String get importModeReplaceHint =>
      'Supprimer toutes les données existantes d\'abord';

  @override
  String get importReplaceWarning =>
      'Cette action supprimera définitivement toutes vos données existantes avant l\'importation.';

  @override
  String get encryptedFileDetected =>
      'Ce fichier est chiffré. Saisissez le mot de passe utilisé lors de l\'exportation.';

  @override
  String get exportSuccess => 'Données exportées avec succès !';

  @override
  String get exportCancelled => 'Exportation annulée.';

  @override
  String importSuccess(int count) {
    return '$count transactions importées avec succès !';
  }

  @override
  String get importCancelled => 'Importation annulée.';

  @override
  String get importError =>
      'Échec de l\'importation des données. Vérifiez le fichier et le mot de passe.';

  @override
  String backupScheduled(String frequency) {
    return 'Sauvegarde automatique programmée ($frequency).';
  }

  @override
  String lastBackup(String date) {
    return 'Dernière sauvegarde : $date';
  }

  @override
  String get noBackupYet => 'Aucune sauvegarde pour le moment';

  @override
  String get ntfBudgetAlertChannelName => 'Alertes budgétaires';

  @override
  String get ntfBudgetAlertChannelDescription =>
      'Alertes lorsque vous approchez de vos limites budgétaires';

  @override
  String get ntfDailyBudgetAlertTitle => 'Alerte budgétaire quotidienne ⚠️';

  @override
  String ntfDailyBudgetAlertBody(int percentage) {
    return 'Vous avez atteint $percentage% de votre limite budgétaire quotidienne';
  }

  @override
  String get ntfWeeklyBudgetAlertTitle => 'Alerte budgétaire hebdomadaire ⚠️';

  @override
  String ntfWeeklyBudgetAlertBody(int percentage) {
    return 'Vous avez atteint $percentage% de votre limite budgétaire hebdomadaire';
  }
}
