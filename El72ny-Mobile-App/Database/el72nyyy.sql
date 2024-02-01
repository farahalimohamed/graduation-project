-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 23, 2023 at 08:59 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `el72nyyy`
--

-- --------------------------------------------------------

--
-- Table structure for table `api_ambulance`
--

CREATE TABLE `api_ambulance` (
  `id` bigint(20) NOT NULL,
  `Lat` varchar(20) NOT NULL,
  `Lng` varchar(20) NOT NULL,
  `available` tinyint(1) NOT NULL,
  `hospital_id` bigint(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_ambulance`
--

INSERT INTO `api_ambulance` (`id`, `Lat`, `Lng`, `available`, `hospital_id`, `password`) VALUES
(1, '31.20225685035377', '29.90507113697273', 1, 2, 'password'),
(2, '31.20225685035377', '29.90507113697273', 1, 2, 'password'),
(3, '31.20295428794973', '29.906229851818594', 1, 3, 'password'),
(4, '31.20295428794973', '29.906229851818594', 1, 3, 'password'),
(5, '31.205102631188954', '29.926092622978302', 1, 4, 'password'),
(6, '31.205102631188954', '29.926092622978302', 1, 4, 'password'),
(7, '31.202307257378504', '29.910174364405837', 1, 1, 'password'),
(8, '31.202307257378504', '29.910174364405837', 1, 1, 'password'),
(9, '31.172983504679614', '29.943425940453775', 1, 5, 'password'),
(10, '31.172983504679614', '29.943425940453775', 1, 5, 'password'),
(11, '31.20884578095651', '29.94665174682932', 1, 6, 'password'),
(12, '31.20884578095651', '29.94665174682932', 1, 6, 'password'),
(13, '31.2073651639792', '29.925792646829315', 1, 7, 'password'),
(14, '31.2073651639792', '29.925792646829315', 1, 7, 'password'),
(15, '31.199436466819222', '29.92390437167567', 1, 8, 'password'),
(16, '31.199436466819222', '29.92390437167567', 1, 8, 'password'),
(17, '31.215293196521465', '29.940898848058463', 1, 9, 'password'),
(18, '31.2240036\n', '29.9360734', 1, 10, 'password');

-- --------------------------------------------------------

--
-- Table structure for table `api_chatmessage`
--

CREATE TABLE `api_chatmessage` (
  `id` bigint(20) NOT NULL,
  `body` longtext DEFAULT NULL,
  `seen` tinyint(1) NOT NULL,
  `msg_receiver_id` bigint(20) NOT NULL,
  `msg_sender_id` bigint(20) NOT NULL,
  `pic` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_chatmessage`
--

INSERT INTO `api_chatmessage` (`id`, `body`, `seen`, `msg_receiver_id`, `msg_sender_id`, `pic`) VALUES
(1, 'hello doc', 0, 1, 4, NULL),
(2, 'hope this will work :)', 0, 1, 4, NULL),
(3, 'hello', 0, 1, 4, NULL),
(4, 'how do you do doc', 0, 1, 4, NULL),
(5, 'hi', 0, 1, 4, NULL),
(6, 'مساء الخير يا دكتور', 1, 1, 2, ''),
(7, 'كنت عايزة حضرتك تشوف الاشعة', 1, 1, 2, ''),
(8, '', 1, 1, 2, 'img/download.jpg'),
(9, 'hello doctor', 0, 12, 2, ''),
(10, 'good evening', 0, 10, 2, ''),
(11, 'مفيش داعى للقلق', 1, 2, 1, ''),
(12, 'الاشاعة تمام', 1, 2, 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `api_firstaid`
--

CREATE TABLE `api_firstaid` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `video` varchar(100) DEFAULT NULL,
  `Description` varchar(5000) DEFAULT NULL,
  `stepNum` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_firstaid`
--

INSERT INTO `api_firstaid` (`id`, `name`, `video`, `Description`, `stepNum`) VALUES
(1, 'Heart Attack - أزمه قلبيه', 'video/angina chest step 1.mp4', 'أولا ساعد المصاب علي الجلوس علي الأرض و ضع وسائد خلف ظهره لكي يكون في وضع مريح', '1'),
(2, 'Heart Attack - أزمه قلبيه', 'video/angina chest step 2.mp4', 'تحقق مما اذا كان المصاب لديه دواء (يكون في أقراص أو بخاخ) و ساعده في تناوله', '2'),
(3, 'Heart Attack - أزمه قلبيه', 'video/angina chest step 3.mp4', 'إذا استمر الألم بعد مرور 5 دقائق اجعل المريض يتناول الدواء مره أخري', '3'),
(4, 'Heart Attack - أزمه قلبيه', 'video/angina chest step 4.mp4', 'إذا استمر الألم بعد الجرعه الثانيه فعليك الأتصال الإسعاف', '4'),
(5, 'choking - الأختناق', 'video/choking step 1.mp4', 'إذا كنت تشك أن المريض يشعر بالاختناق قم بسؤاله لأنه من المهم التأكد أن هذا ما يحدث', '1'),
(6, 'choking - الأختناق', 'video/choking step 2.mp4', 'إذا كان المصاب يتنفس فشجعه علي السعال هذا يساعد علي طرد أي عنصر يساعده علي الاختناق أو يسد الهواء عنه', '2'),
(7, 'choking - الأختناق', 'video/choking step 3.mp4', 'إذا لم يساعد السعال ولم يتمكن المصاب من التحدث أو التنفس، ينبغي ضرب ظهره حوالي ٥ مرات باستخدام كعب يديك بين لوحي الكتف.', '3'),
(8, 'choking - الأختناق', 'video/choking step 4.mp4', 'قف خلف المصاب وضع زراعيك حول الجزء العلوي من البطن تأكد من انحناءه إلي الأمام وشد قبضتيك وضعها بين السرة وأسفل عظمه الصدر أمسك قبضه يدك بقوة باليد الأخري واسحب بحده للداخل  5 مرات', '4'),
(9, 'choking - الأختناق', 'video/choking step 5.mp4', 'افحص فم المصاب, إذا كان لا يزال يعاني من الأختناق إذا عليك بالاتصال بالإسعاف', '5'),
(10, 'choking - الأختناق', 'video/choking step 6.mp4', 'قم بإعادة 3 و 4 حتي تصل الاسعاف إليك ', '6'),
(11, 'Chocking-الأختناق', 'video/CPR.mp4', 'إذا توقف عن الإستجابة قبل وصول الإسعاف استعدلبدء الانعاش القلبي الرئوي عن طريق ضغط الصدر30 مرة في الدقيقه ', '11'),
(12, 'Car Accident - حادث سير', 'video\\car acc6.mp4', 'أسأل المصاب عن اسمه وعن اليوم ولاحظ إجابته مع ابلاغ المسعفين\nوأنتظر قدوم الإسعاف', '1'),
(13, 'Car Accident - حادث سير', 'video\\car acc4.mp4', 'تفقد التنفس عن طريق وضع أذنك علي فم وأنف المصاب ', '1'),
(14, 'Car Accident - حادث سير', 'video\\car acc2.mp4', 'إذا كان المصاب لا يتنفس بصورة طبيعيه قم بالتأكد انه لا يوجد اي عوائق في الفم أو الحلق', '2'),
(15, 'Car Accident - حادث سير', 'video\\car acc', 'أفحص نبض المصاب عن طريق وضع إصبعين علي رقبه المصاب إلي جانب الحنجره', '3'),
(16, 'Car Accident - حادث سير', 'video\\car acc5.mp4', 'يجب وضع المريض علي جانبه لمنع الاختناق \nوأنتظر قدوم الأسعاف\n', '1'),
(17, 'Car Accident - حادث سير', 'video\\car acc3.mp4', ' فقم بوقف النزيف عن طريق الضغط علي \n الجروح باستخدام قماش بكف اليد وليس الاصابع وأنتظر قدوم الأسعاف', '1'),
(18, 'CPR', 'video/CPR.mp4', 'ابدأ بإجراء الإنعاش القلبي الرئوي عن طريق ضغط الصدر بمعدل 30 ضغطة في الدقيقة، قم بوضع كفي يدك فوق الأخرى في منتصف الصدر  وقم بالضغط ثم اسمح للصدر بالارتفاع بشكل كامل بين كل ضغطة.', '1'),
(19, 'Major burns-حروق', 'video/major burns step 1.mp4', 'اغسل الحرق بماء برد لمده 20 دقيقه', '1'),
(20, 'Major burns-حروق', 'video/major burns step 2.mp4', 'استمر في غسل الحرق بالماء واستخدام المرطبات حتي وصول الإسعاف', '2'),
(21, 'Major burns-حروق', 'video/minor burns step 3.mp4', 'قم بإزاله اي ملابس أو مجوهرات قريبه من منطقه الحرق مع عدم الأقتراب من منطقة الحرق', '3'),
(22, 'Major burns-حروق', 'video/minor burns step 4.mp4', 'حاول أن  تغطي الحرق بكيس بلاستيكي حتي تقلل من العدوي', '4'),
(23, 'Minor burns-حروق', 'video/minor burns step 1.mp4', 'اغسل الحرق بمياه برد لمده 20 دقيقة\r\n(ملحوظه)يتم أستدعاء الإسعاف فقط اذا لزم الأمر', '1'),
(24, 'Minor burns-حروق', 'video/minor burns step 3.mp4', 'قم بإزاله اي ملابس او مجوهرات قريبه من منطقه الحرق', '2'),
(25, 'Minor burns-حروق', 'video/minor burns step 3.mp4', 'قم بوضع ضماضه معقمه علي الجرج عشان نحمي الحرق من العدوي', '3'),
(26, 'Allergies-حساسية', 'video\\Allergies step 1.mp4', 'حالة خطيرة، لذا يجب عليك الاتصال بالإسعاف على الفور.', '1'),
(27, 'Allergies-حساسية', 'video/allergies step 2.mp4', 'اسأل المصاب إذا كان لديه حقنة (لأنهم غالبا يحملون حقنه الأدرنالين) يجب أن تبقى في مكانها لمدة ثلاث ثوانٍ', '2'),
(28, 'Allergies-حساسية', 'video/allergies step 3.mp4', 'إذا كان الشخص يعاني صعوبة في التنفس أكثر من المعتاد أو صوت شخير  يمكن إعطاء الحقنة الثانية بعد خمس دقائق', '3'),
(29, 'Allergies-حساسية', 'video/allergies step 4.mp4', 'إذا لم يحدث تحسن بعد الجرعه التانيه. ضعه على ظهره مع رفع الأرجل', '4'),
(30, 'Allergies-حساسية', 'video/CPR.mp4', 'يمكن أن تزداد حالة المصاب سوءًا.عند ذلك وتحقق من تنفسهم ونبضهم. إذا لم يكن هناك تنفس، بدء عملية الإنعاش القلبي الرئوي', '5'),
(31, 'Asthma-الربو', 'video\\Asthma1.mp4', 'ساعد المريض على الجلوس في وضع مريح وشجعه على التنفس ببطء', '1'),
(32, 'Asthma-الربو', 'video\\Asthma2.mp4', 'أسأله هل لديه بخاخه صدر وساعده في استخدامها تم أطلب منه التنفس ببطء\r\nإذا اختفت أعراض الربو بعد دقائق فلا حاجه للاتصال بالإسعاف', '2'),
(33, 'Asthma-الربو', 'video\\Asthma3.mp4', ' إذا لم تتحسن الأعراض بعد بضع دقائق اتصل بالإسعاف', '3'),
(34, 'Asthma-الربو', 'video/CPR.mp4', 'حالة المريض قد تزداد سوءا ويمكن أن يصل الأمر إلى عدم الاستجابة. إذا حدث ذلك، فكن مستعدًا لاستخدام الإسعافات الأولية الأساسية وبدء عمليات إنعاش القلب والرئتين(CPR).', '4'),
(35, 'Bites and Stings-العضات واللدغات', 'video\\bites 1.mp4', 'يجب عليك تنظيف الجرح لتقليل خطر العدوى. اغسل الجرح جيدًا بالصابون والماء', '1'),
(36, 'Bites and Stings-اللدغات والعضات', 'video\\bites step3.mp4', '.استخدم ضمادة جرح نظيفة ومعقمة لتغطية العضة', '2'),
(37, 'Bites and Stings-العضات واللدغات', 'video\\bites step4.mp4', 'إذا كان الجرح كبيرًا أو عميقًا، فيجب نقل المصاب إلى المستشفى. وبالنسبة للعضات الأخرى التي تخترق الجلد، يجب البحث عن علامات العدوى مثل الاحمرار والتورم والتهابات الجلد، وفي حالة وجودها، يجب الاتصال بالإسعاف', '3'),
(38, 'Nosebleed-نزيف الأنف', 'video\\bleeding 1.mp4', ' ضع المصاب بحيث يميل إلي الأمام لمنع الدم من التسرب إلي الأنف والفم والحلق', '1'),
(39, 'Nosebleed-نزيف الأنف', 'video\\bleeding 2.mp4', 'اطلب منه ضغط الجزء الناعم من أنفهم لمدة 10دقائق', '2'),
(40, 'Nosebleed-نزيف الأنف', 'video\\bleeding 3.mp4', 'إذا كان لا يزال هناك نزيف، فاطلب منهم مواصلة الضغط على أنفهم لمدة 10دقائق إضافية', '3'),
(41, 'Nosebleed-نزيف الأنف', 'video\\nosebleed 4.mp4', 'إذا لم يتوقف النزيف بعد ما يصل إلى 30 دقيقة كحد أقصى، فمن الآن عليك الاتصال بالأسعاف', '4'),
(42, 'Severebleed-نزيف حاد', 'video\\serve bleeding 1.mp4', 'إذا كنت تستطيع وضع القفازات الجراحية النظيفة، فهذا سيساعد على تقليل خطر العدوى لك وللمصاب', '1'),
(43, 'Severebleed-نزيف حاد', 'video\\serve bleeding 2.mp4', 'قم بالضغط على الجرح،  يجب فعل ذلك فقط إذا تأكدت من عدم وجود أي شيء ملتصق داخل الجرح، مثل قطعة زجاج', '2'),
(44, 'Severebleed-النزيف الحاد', 'video\\serve bleeding 3.mp4', 'يجب الآن وضع ضمادة على الجرح', '3'),
(45, 'Severebleed-النزيف الحاد', 'video\\serve bleeding 4.mp4', 'أتصل بالإسعاف,وأثناء وصولها راقب الجرح وإذا ظهر نزيف علي الضماده إعادة الضغط على ضمادة جديدة للسيطرة على النزيف ويجب الاستمرار في الضغط حتى يتوقف النزيف ', '4'),
(46, 'Shock-الصدمة', 'video\\deal with chock 1.mp4', 'تطبيق الضغط على الجرح للسيطرة على النزيف، وتثبيت أي عظام مكسورة، أو استخدام ضمادة باردة لتقليل الانتفاخ', '1'),
(47, 'Shock-الصدمة', 'video\\deal with chock 2.mp4', 'إذا كان الشخص واعيًا ويتنفس، فلتستلقي بأقدامه مرتفعة، مالم يكن لديه إصابة في الرأس أو العنق أو الظهر.\n', '2'),
(48, 'Shock-الصدمة', 'video\\deal with chock 3.mp4', 'الاتصال بالمساعدة الطبية الطارئة على الفور', '3'),
(49, 'Shock-الصدمة', 'video\\deal with chock 4.mp4', 'فك أي ملابس ضيقة، مثل الأحزمة أو الياقات', '4'),
(50, 'Shock-الصدمة', 'video\\deal with chock 5.mp4', 'تغطية الشخص ببطانية أو معطف للحفاظ عليه دافئًا', '5');

-- --------------------------------------------------------

--
-- Table structure for table `api_hospital`
--

CREATE TABLE `api_hospital` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `lat` varchar(20) NOT NULL,
  `lng` varchar(20) NOT NULL,
  `password` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_hospital`
--

INSERT INTO `api_hospital` (`id`, `name`, `lat`, `lng`, `password`) VALUES
(1, 'مستشفى السلامة الجديدة', '31.202307257378504', '29.910174364405837', 'password'),
(2, 'Alexandria University Main Hospital', '31.20236797443182', '29.905415473686432', 'password'),
(3, 'El Miri hospital', '31.202863522130126', '29.906437395329068', 'password'),
(4, 'Gamal AbdelNaser Hospital', '31.205102631188954', '29.926092622978302', 'password'),
(5, 'Elite Hospital', '31.172983504679614', '29.943425940453775', 'password'),
(6, 'Smouha University Emergency Hospital', '31.20884578095651', '29.94665174682932', 'password'),
(7, 'Gamal Abd El Naser Hospital', '31.2073651639792', '29.925792646829315', 'password'),
(8, 'Nareman Hospital', '31.199436466819222', '29.92390437167567', 'password'),
(9, 'Middle East Hospital', '31.215293196521465', '29.940898848058463', 'password'),
(10, 'Andalusia Hospital Antoniadis', '31.21043920821641', '29.947708201318903', 'password');

-- --------------------------------------------------------

--
-- Table structure for table `api_profile`
--

CREATE TABLE `api_profile` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone_number` varchar(11) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `blood_type` varchar(3) DEFAULT NULL,
  `allergies` varchar(100) DEFAULT NULL,
  `weight` varchar(10) DEFAULT NULL,
  `medical_condition` varchar(100) DEFAULT NULL,
  `pic` varchar(100) DEFAULT NULL,
  `is_doctor` tinyint(1) NOT NULL,
  `doctorId` varchar(100) DEFAULT NULL,
  `specialization` varchar(100) NOT NULL,
  `online` tinyint(1) NOT NULL,
  `availability` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `rate` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_profile`
--

INSERT INTO `api_profile` (`id`, `name`, `phone_number`, `birthdate`, `gender`, `blood_type`, `allergies`, `weight`, `medical_condition`, `pic`, `is_doctor`, `doctorId`, `specialization`, `online`, `availability`, `user_id`, `rate`) VALUES
(1, 'Ahmed ElMasry', '01234567890', '1967-03-01', 'Male', 'A+', '', '', '', 'img\\am.jpg', 1, '', 'eye', 1, '12pm - 5pm', 1, 2),
(2, 'farha Moustafa', '01118761066', '2001-09-30', 'Female', 'AB+', 'none', '75', 'short eye sight ', 'img\\sea.jpg', 0, '', '', 0, '', 2, 3),
(4, 'nour shawky', '01221230085', '2023-03-01', 'Female', 'A+', '', '', '', 'img\\sea.jpg', 0, '', '', 0, '', 56, NULL),
(8, 'Maha Muhammed', '01118761066', '2001-09-30', 'female', 'A+', '', '65', '', 'img/unnamed.jpg', 1, 'img/unnamed.jpg', 'Gynaecology', 0, '12 pm - 6 am', 64, 4),
(9, 'Mohamed Nour', '0100665321', '1967-08-05', 'female', 'AB', '', '65', '', 'img\\mohaed nour.jpeg', 1, 'img/unnamed.jpg', 'Dentist', 1, '12 pm - 6 am', 65, 3),
(10, 'Ahmed El Watidy', '01188954223', '1987-09-10', 'male', '', '', '', '', 'img\\doc1.jpg', 1, 'img/unnamed.jpg', 'Cardiothoracic Surgeon', 0, '3 pm - 9 pm', 72, 5),
(11, 'Sameh Shehata', '01003442187', '1992-01-01', 'male', '', '', '', '', 'img\\doc2.jpeg', 1, 'img/unnamed.jpg', 'Pediatric Surgery', 0, '10 am - 8 pm', 73, 4.5),
(12, 'Waleed Fawzi', '01223215578', '1996-10-15', 'male', '', '', '', '', 'img\\doc5.jpeg', 1, 'img/unnamed.jpg', 'Bones', 0, '12 pm - 6 pm', 74, 4),
(13, 'Yasser el shopky', '01188954223', '1996-03-10', 'male', '', '', '', '', 'img\\doc4.jpeg', 1, 'img/unnamed.jpg', 'Arthroscopy and Sport injuries', 0, '8 pm - 12 am', 75, 2.5),
(14, 'Marwa abd el baki', '01187454223', '1989-09-10', 'female', '', '', '', '', 'img\\dr1.jpeg', 1, 'img/unnamed.jpg', 'Ear and Nose', 0, '3 pm - 9 pm', 76, 3),
(15, 'Ibrahim Qotb', '01115239971', '1999-04-20', 'male', '', '', '', '', 'img\\doc3.jpg', 1, 'img/unnamed.jpg', 'Ear, Nose, Throat and Rhinoplasty', 0, '3 pm - 9 pm', 77, 3.5),
(16, 'Doaa Talaat', '01281231234', '1963-09-27', 'Female', 'AB+', '', '', '', 'img\\DT.jpg', 1, '', 'Family Physician', 0, '10 am - 4 pm', 79, 5);

-- --------------------------------------------------------

--
-- Table structure for table `api_requesthospital`
--

CREATE TABLE `api_requesthospital` (
  `id` bigint(20) NOT NULL,
  `userId` varchar(30) NOT NULL,
  `userlat` double NOT NULL,
  `userlng` double NOT NULL,
  `seen` tinyint(1) NOT NULL,
  `hospital_id` bigint(20) NOT NULL,
  `userCase` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_tracking`
--

CREATE TABLE `api_tracking` (
  `id` bigint(20) NOT NULL,
  `ambulance_id` bigint(20) NOT NULL,
  `userId` varchar(20) NOT NULL,
  `userLat` varchar(20) NOT NULL,
  `userLng` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_tracking`
--

INSERT INTO `api_tracking` (`id`, `ambulance_id`, `userId`, `userLat`, `userLng`) VALUES
(5, 18, '0', '31.172983504679614 ', '29.943425940453775');

-- --------------------------------------------------------

--
-- Table structure for table `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add ambulance', 7, 'add_ambulance'),
(26, 'Can change ambulance', 7, 'change_ambulance'),
(27, 'Can delete ambulance', 7, 'delete_ambulance'),
(28, 'Can view ambulance', 7, 'view_ambulance'),
(29, 'Can add firstaid', 8, 'add_firstaid'),
(30, 'Can change firstaid', 8, 'change_firstaid'),
(31, 'Can delete firstaid', 8, 'delete_firstaid'),
(32, 'Can view firstaid', 8, 'view_firstaid'),
(33, 'Can add profile', 9, 'add_profile'),
(34, 'Can change profile', 9, 'change_profile'),
(35, 'Can delete profile', 9, 'delete_profile'),
(36, 'Can view profile', 9, 'view_profile'),
(37, 'Can add tracking', 10, 'add_tracking'),
(38, 'Can change tracking', 10, 'change_tracking'),
(39, 'Can delete tracking', 10, 'delete_tracking'),
(40, 'Can view tracking', 10, 'view_tracking'),
(41, 'Can add checkup form', 11, 'add_checkupform'),
(42, 'Can change checkup form', 11, 'change_checkupform'),
(43, 'Can delete checkup form', 11, 'delete_checkupform'),
(44, 'Can view checkup form', 11, 'view_checkupform'),
(45, 'Can add chat message', 12, 'add_chatmessage'),
(46, 'Can change chat message', 12, 'change_chatmessage'),
(47, 'Can delete chat message', 12, 'delete_chatmessage'),
(48, 'Can view chat message', 12, 'view_chatmessage'),
(49, 'Can add auth token', 13, 'add_authtoken'),
(50, 'Can change auth token', 13, 'change_authtoken'),
(51, 'Can delete auth token', 13, 'delete_authtoken'),
(52, 'Can view auth token', 13, 'view_authtoken'),
(53, 'Can add hospital', 14, 'add_hospital'),
(54, 'Can change hospital', 14, 'change_hospital'),
(55, 'Can delete hospital', 14, 'delete_hospital'),
(56, 'Can view hospital', 14, 'view_hospital'),
(57, 'Can add request hospital', 15, 'add_requesthospital'),
(58, 'Can change request hospital', 15, 'change_requesthospital'),
(59, 'Can delete request hospital', 15, 'delete_requesthospital'),
(60, 'Can view request hospital', 15, 'view_requesthospital'),
(61, 'Can add Token', 16, 'add_token'),
(62, 'Can change Token', 16, 'change_token'),
(63, 'Can delete Token', 16, 'delete_token'),
(64, 'Can view Token', 16, 'view_token'),
(65, 'Can add token', 17, 'add_tokenproxy'),
(66, 'Can change token', 17, 'change_tokenproxy'),
(67, 'Can delete token', 17, 'delete_tokenproxy'),
(68, 'Can view token', 17, 'view_tokenproxy');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$390000$0p9WsROdqdrtVjWTiYWZib$B1P81rHsIt+2O3D1w7Qhgt+1evxomG3pIfcG2VDiiQc=', '2023-06-22 16:07:53.226568', 0, 'ahmedelmasry', '', '', 'ahmedelmasry@gmail.com', 0, 1, '2023-05-31 18:21:52.435329'),
(2, 'pbkdf2_sha256$390000$uEHIqXrfp779QnUL0iKcqx$yRp/flKJNs8wQdy+/OmZHvygNBY2pZCexLjUhocHJw4=', '2023-06-23 10:25:52.681152', 0, 'farha', '', '', 'farhamoustafasaid@gmail.com', 0, 1, '2023-05-31 18:29:02.934553'),
(56, 'pbkdf2_sha256$600000$hhgfnh2VGotRxu53IrOmiv$At4zD+v5N8Fp1SBQwubwPeuTUI1aaVglhb0afAqNGGc=', '2023-06-20 21:04:36.899722', 0, 'nour', '', '', 'nour@gmail.com', 0, 1, '2023-06-13 22:16:58.616916'),
(57, 'pbkdf2_sha256$600000$s2aF9HyYLvAFOvoKjP5CAt$9efZXNUL+8badvPrRpK6KkuoiIDgccASPmT1/EHWNBI=', '2023-06-19 02:13:41.219162', 1, 'nourhan', '', '', 'nour@gmail.com', 1, 1, '2023-06-15 13:23:13.674820'),
(64, 'pbkdf2_sha256$600000$fUf43Xd7e14L1FMej0lTud$8dyVSpbEsqe08P9CKljmf8iTOSNWdnGZBhlDTnalQKA=', NULL, 0, 'Maha', '', '', 'maha@example.com', 0, 1, '2023-06-15 13:59:45.768659'),
(65, 'pbkdf2_sha256$600000$uCtZtjHnPNDdlDXfK3VnnH$mgaK8X+N04bo7Qu8whDdxQxiRxBKWGQNAzC/E43SEw0=', NULL, 0, 'Mohamed Nour', '', '', 'Mohamed Nour@example.com', 0, 1, '2023-06-15 14:07:59.998045'),
(72, 'pbkdf2_sha256$600000$hCgOfCR0IMYuN6Vrm03r6Z$3HcjiZ5pJin/oygl82Qr4jDxhGKZiqMURfJpdPtLOYg=', NULL, 0, 'Ahmed', '', '', 'El Watidy@example.com', 0, 1, '2023-06-19 02:44:08.981754'),
(73, 'pbkdf2_sha256$600000$ImLwahpqrhl5sg5Lp7H4ea$OP4BXdOb1vq2BUS42aypZ6gSGgbWRZL4qSgG7VlL7xs=', NULL, 0, 'Sameh', '', '', 'Shehata@example.com', 0, 1, '2023-06-19 02:53:06.681541'),
(74, 'pbkdf2_sha256$600000$rDaPRXbWwqIFbHTm2ymaEI$6F1jSV5u9jD6AIaqHLfNnJUE98vvSIkC8faF5THSZ48=', NULL, 0, 'Waleed', '', '', 'WF@example.com', 0, 1, '2023-06-19 02:56:58.162217'),
(75, 'pbkdf2_sha256$600000$Y6q2XJCViZodWe0AHngLi1$Vp5Y13jGmnnK1uTCU3c03pOXNYvQV0BOeQAIr+I3fMU=', NULL, 0, 'shopky', '', '', 'Yassersh10@example.com', 0, 1, '2023-06-19 03:01:47.650119'),
(76, 'pbkdf2_sha256$600000$LSFcmbP74MWwh0NqeiP6Nf$3yaPGChEXP2m5UKVBmYcZXhPD6KICYIVFIAMdVIsv2c=', NULL, 0, 'Marwa', '', '', 'M2020@example.com', 0, 1, '2023-06-19 03:05:07.270453'),
(77, 'pbkdf2_sha256$600000$mjUXN8U9VwFH1os0IdQrwF$mSx5/RfzvbhTKzl1WstTqh5aYXy+TQnWquBZamGxK58=', NULL, 0, 'Qotb', '', '', 'QOTB@example.com', 0, 1, '2023-06-19 03:07:22.011371'),
(79, 'pbkdf2_sha256$390000$f9sjEL1lgetZ3RDAIw9aUq$Ax2JpkO2Qh6IbidGU+ZyiMdOck2Gn+116Uva+p7Oggg=', NULL, 0, 'doaatalaat', '', '', 'doaa@gmail.com', 0, 1, '2023-06-22 16:59:42.605814');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(7, 'API', 'ambulance'),
(12, 'API', 'chatmessage'),
(11, 'API', 'checkupform'),
(8, 'API', 'firstaid'),
(14, 'API', 'hospital'),
(9, 'API', 'profile'),
(15, 'API', 'requesthospital'),
(10, 'API', 'tracking'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(16, 'authtoken', 'token'),
(17, 'authtoken', 'tokenproxy'),
(5, 'contenttypes', 'contenttype'),
(13, 'knox', 'authtoken'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-05-15 21:35:43.759618'),
(2, 'auth', '0001_initial', '2023-05-15 21:35:50.148051'),
(3, 'API', '0001_initial', '2023-05-15 21:35:58.093867'),
(4, 'admin', '0001_initial', '2023-05-15 21:35:59.382636'),
(5, 'admin', '0002_logentry_remove_auto_add', '2023-05-15 21:35:59.436617'),
(6, 'admin', '0003_logentry_add_action_flag_choices', '2023-05-15 21:35:59.491050'),
(7, 'contenttypes', '0002_remove_content_type_name', '2023-05-15 21:36:00.150179'),
(8, 'auth', '0002_alter_permission_name_max_length', '2023-05-15 21:36:00.838006'),
(9, 'auth', '0003_alter_user_email_max_length', '2023-05-15 21:36:01.015976'),
(10, 'auth', '0004_alter_user_username_opts', '2023-05-15 21:36:01.046215'),
(11, 'auth', '0005_alter_user_last_login_null', '2023-05-15 21:36:01.555912'),
(12, 'auth', '0006_require_contenttypes_0002', '2023-05-15 21:36:01.593986'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2023-05-15 21:36:01.634405'),
(14, 'auth', '0008_alter_user_username_max_length', '2023-05-15 21:36:01.882906'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2023-05-15 21:36:02.233382'),
(16, 'auth', '0010_alter_group_name_max_length', '2023-05-15 21:36:02.405378'),
(17, 'auth', '0011_update_proxy_permissions', '2023-05-15 21:36:02.446921'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2023-05-15 21:36:02.672069'),
(19, 'knox', '0001_initial', '2023-05-15 21:36:03.827198'),
(20, 'knox', '0002_auto_20150916_1425', '2023-05-15 21:36:04.659953'),
(21, 'knox', '0003_auto_20150916_1526', '2023-05-15 21:36:04.744417'),
(22, 'knox', '0004_authtoken_expires', '2023-05-15 21:36:04.827055'),
(23, 'knox', '0005_authtoken_token_key', '2023-05-15 21:36:05.116005'),
(24, 'knox', '0006_auto_20160818_0932', '2023-05-15 21:36:05.553014'),
(25, 'knox', '0007_auto_20190111_0542', '2023-05-15 21:36:05.672047'),
(26, 'knox', '0008_remove_authtoken_salt', '2023-05-15 21:36:05.828102'),
(27, 'sessions', '0001_initial', '2023-05-15 21:36:06.127531'),
(28, 'API', '0002_remove_profile_lat_remove_profile_lng_and_more', '2023-05-24 19:13:12.535114'),
(29, 'API', '0003_remove_firstaid_steps_ambulance_available_and_more', '2023-05-31 16:42:38.310944'),
(30, 'API', '0004_hospital_alter_ambulance_available_requesthospital', '2023-06-07 10:20:32.756013'),
(31, 'API', '0005_ambulance_hospital', '2023-06-07 10:44:57.402313'),
(32, 'API', '0006_ambulance_password', '2023-06-07 13:54:36.410888'),
(33, 'API', '0007_profile_rates', '2023-06-15 14:12:09.342977'),
(34, 'API', '0008_alter_profile_rates', '2023-06-15 15:25:04.053349'),
(35, 'API', '0007_requesthospital_usercase', '2023-06-18 12:19:54.404058'),
(36, 'API', '0008_hospital_password', '2023-06-18 12:19:54.472794'),
(37, 'API', '0009_alter_profile_online', '2023-06-18 12:19:54.616846'),
(38, 'API', '0010_profile_rate', '2023-06-18 12:19:54.661416'),
(39, 'API', '0011_alter_profile_rate', '2023-06-18 12:19:54.801365'),
(40, 'API', '0012_chatmessage_pic_alter_chatmessage_body', '2023-06-22 15:28:44.553706'),
(41, 'authtoken', '0001_initial', '2023-06-22 15:28:45.451857'),
(42, 'authtoken', '0002_auto_20160226_1747', '2023-06-22 15:28:45.501170'),
(43, 'authtoken', '0003_tokenproxy', '2023-06-22 15:28:45.520036');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('0v19afm9nfcix74tni69eiu4wk8kb2t9', 'e30:1q9Beg:wZewQJ4Sd0zI3rA3G9WODOUYGOdD7p_3Skhtj9DG9AQ', '2023-06-27 21:34:22.687143'),
('0zsrsnw30oagzbnj5l58n3j92rzkpzlb', 'e30:1q9BdZ:fE8uH0Sif75-S6jh9gaHSgqMYC3poqjipU9Jkbz2IiM', '2023-06-27 21:33:13.663480'),
('2u83twg3znr7z31fdidowc9kxms1jh5a', '.eJxVjDsOwjAQBe_iGln-W6ak5wzWeneDA8iW4qRC3B0ipYD2zcx7iQzbWvM2eMkzibPwQZx-xwL44LYTukO7dYm9rctc5K7Igw557cTPy-H-HVQY9VtPaMBSCsUxEiQbaIoakUkZ0CUygEq2sArJm-iJkwU0zhE4clEHEu8PQyE5Hg:1qBaom:hCSFTudc6cxkNTtRrlMfSLvn8h9iLgJPFNYccQWN--0', '2023-07-04 12:50:44.087013'),
('3swp1f1fku07iw74vx4fqcjuozbc3msh', '.eJxVjDEOgzAQBP_iOrLOxjaQMj1vsO5855gkAglDFeXvAYkiKbbZmd23iritJW5VljiyuiqrLr8dYXrKdAB-4HSfdZqndRlJH4o-adXDzPK6ne7fQcFa9rWjjJ6aZHsDQbqAIDZRFtjjWiAj4H02vTPsWDyLMCTXttIxUhM69fkCBi445g:1qCRpa:qRZ8dDKNxbELi_UeJreYVhwrOx-TgvUvIemyfaWAOzo', '2023-07-06 21:27:06.655412'),
('4ep0mtufo9orpv81ugzh4lrvr38awov7', '.eJxVjDsOwjAQBe_iGln-W6ak5wzWeneDA8iW4qRC3B0ipYD2zcx7iQzbWvM2eMkzibPwQZx-xwL44LYTukO7dYm9rctc5K7Igw557cTPy-H-HVQY9VtPaMBSCsUxEiQbaIoakUkZ0CUygEq2sArJm-iJkwU0zhE4clEHEu8PQyE5Hg:1qBi5o:ek02ebOczuaAYNramkWjyqj_DfgPNTx1KyY0jQ5hjBA', '2023-07-04 20:36:48.225977'),
('4opkelab6mnzkd93txeogah6jpro32uf', 'e30:1q9BdZ:fE8uH0Sif75-S6jh9gaHSgqMYC3poqjipU9Jkbz2IiM', '2023-06-27 21:33:13.896109'),
('6aaspdxe5utld1qgj5ktuusvx3ua49xd', '.eJxVjEEOwiAQRe_C2hBKmaG4dO8ZyACDVA0kpV0Z765NutDtf-_9l_C0rcVvnRc_J3EWgOL0OwaKD647SXeqtyZjq-syB7kr8qBdXlvi5-Vw_w4K9fKtLSBZBswDUI4qM44OtQU9BVDBmikoQy6gG8dIqJHRkmJ2AzqOyTjx_gD8TzfG:1q9CK3:AmtcXzzQgwH99zYiHz7uNRvu0NJLYRBhV59XamFiS5o', '2023-06-27 22:17:07.210209'),
('6wc0vubbptu5ncnei69pso6921z5mbsu', '.eJxVjDEOgzAQBP_iOrLOxjaQMj1vsO5855gkAglDFeXvAYkiKbbZmd23iritJW5VljiyuiqrLr8dYXrKdAB-4HSfdZqndRlJH4o-adXDzPK6ne7fQcFa9rWjjJ6aZHsDQbqAIDZRFtjjWiAj4H02vTPsWDyLMCTXttIxUhM69fkCBi445g:1qCdzD:Fom0Fg3a_Ij_Wb7iHbToGHIQvyOwi2j5NBFtGj0r8S8', '2023-07-07 10:25:51.345125'),
('84zm5jv032nw4dzrmkazv12lr8z6q11i', '.eJxVjEEOwiAQRe_C2hCgOKBL9z0DmWFAqgaS0q6Md7dNutDtf-_9twi4LiWsPc1hYnEVRpx-N8L4THUH_MB6bzK2uswTyV2RB-1ybJxet8P9OyjYy1YreyaCiFlZYO0JgSkPrJM1NvqBILtEAzpUmS4eGBk1u2ggb9igEZ8vC1w5Dg:1q9y1C:hQDostxCWOCKPDtD4TkS7sfS-cxvNv_yroYNYPIcbJU', '2023-06-30 01:12:50.384422'),
('8wi5od7iam0o9kqeivd9k658ps7zixw6', 'e30:1q9BdV:JyEXsIb9C38AbBUg8ok4Q-oMd1JXALk_wLkqOmprFU8', '2023-06-27 21:33:09.910635'),
('9nqaqyw1qwk0hvod7x36bfi6z7xzdsm7', '.eJxVjMsOwiAQRf-FtSEMw9Ole7-BAANSNTQp7cr479qkC93ec859sRC3tYVtlCVMxM5MG3b6HVPMj9J3QvfYbzPPc1-XKfFd4Qcd_DpTeV4O9--gxdG-dVJCOfQSLRmowoJwThhp0RupCVOtIgIpDUlLj1izVkRQnQGnI2TB3h_KETax:1q9yUQ:e28UPxp6t2J0dUUGDgFSDJQ4UTwLTestXPU147JtseY', '2023-06-30 01:43:02.827890'),
('cb55f6oz2p96kiig63yiosw3wtuhk5s0', 'e30:1q9BdV:JyEXsIb9C38AbBUg8ok4Q-oMd1JXALk_wLkqOmprFU8', '2023-06-27 21:33:09.369278'),
('cj4n1ffmgpio6jovc3n4ol82essxis4m', '.eJxVjEEOwiAQRe_C2hBKmaG4dO8ZyACDVA0kpV0Z765NutDtf-_9l_C0rcVvnRc_J3EWgOL0OwaKD647SXeqtyZjq-syB7kr8qBdXlvi5-Vw_w4K9fKtLSBZBswDUI4qM44OtQU9BVDBmikoQy6gG8dIqJHRkmJ2AzqOyTjx_gD8TzfG:1q9DzQ:aYr6xcfbd9DaGN9vghUblXj2HF7sAYYeCpxlpM77enY', '2023-06-28 00:03:56.626157'),
('ctalkcdzzq522ohw08sw5ois4xdt6q2d', '.eJxVjDsOwjAQBe_iGlnx36ak5wzW7nqDA8iR4qRC3B0ipYD2zcx7iQzbWvPWeclTEWehxel3Q6AHtx2UO7TbLGlu6zKh3BV50C6vc-Hn5XD_Dir0-q2jUQWIDI1pcNYWFQNCcKxHA9FF0CmkSEp5RjNoh9azDUk7hRG8tUq8P9u9Nxc:1q6u9b:gsEnvCe1BwQVYKxBXSNy4il8dI7FMFb0y0TyOlfStFA', '2023-06-21 14:28:51.688252'),
('d1dhsjawu75obomim4zz90dxyp0p92bt', '.eJxVjEEOwiAQRe_C2hBKmaG4dO8ZyACDVA0kpV0Z765NutDtf-_9l_C0rcVvnRc_J3EWgOL0OwaKD647SXeqtyZjq-syB7kr8qBdXlvi5-Vw_w4K9fKtLSBZBswDUI4qM44OtQU9BVDBmikoQy6gG8dIqJHRkmJ2AzqOyTjx_gD8TzfG:1q9DmU:g4HwYQ5g-wP93JHcqYOpKWb0hpdadqRCQQzpeNFD4dU', '2023-06-27 23:50:34.354945'),
('d1i1zripbtbcvjjuzkhhfwagtzwh4mrm', 'e30:1q9BdT:PHnmxOWH3W-x3wWwTa00OzvWKle8xxIM03bY241RWA8', '2023-06-27 21:33:07.690328'),
('dorg57x8yixsc1oxrpt48ytvmy7ry2yu', '.eJxVjEEOwiAQRe_C2hBKmaG4dO8ZyACDVA0kpV0Z765NutDtf-_9l_C0rcVvnRc_J3EWgOL0OwaKD647SXeqtyZjq-syB7kr8qBdXlvi5-Vw_w4K9fKtLSBZBswDUI4qM44OtQU9BVDBmikoQy6gG8dIqJHRkmJ2AzqOyTjx_gD8TzfG:1q9CzV:VdRQ0tquSPQTPIi9rdQwdnefevnLM5Ve3SFJfxr8Xx8', '2023-06-27 22:59:57.645902'),
('eei0c6co0udarxdn3l8fr7r0tdrgrvuv', 'e30:1q9BdX:P6K5WjbTxNPyxZUtDCYiGdis2glsBrQlosGLCI4QYO0', '2023-06-27 21:33:11.404422'),
('efr3cvgfhqei4wfp593lcfxx5q5pjnq1', 'e30:1q9BdJ:toc6sabdHFq-Y1soDet6xy3nFyhFtfg1oaFpkpCB5jM', '2023-06-27 21:32:57.920174'),
('f7i87wv5swwxj5taqir0nbp9cp96cmbw', '.eJxVjDsOwyAQBe9CHSFjvk6Z3mdALLsEJxFIxq6i3D1YcpG0M_Pem_mwb9nvjVa_ILsybdjlF0KITyqHwUco98pjLdu6AD8SftrG54r0up3t30EOLfc1WFQQB5dGsk5KQ0hkjNRCJxs7Eso4HAcnkoqIIUkBCVTvJpgQBmKfLx2XONs:1q9ySz:cjZ2FYZdDKdJAHwlXrD4lSm8TVFTPgfaVH2etYxlesA', '2023-06-30 01:41:33.208610'),
('fzm0om6xw6sxvsc254fmarradj9ybaz8', 'e30:1q9BcX:dG-ifrkMWyUJR0v331yVfpCAdqcxGyG5QQr3GOjbgO4', '2023-06-27 21:32:09.366628'),
('g04k3y7nhbogzdqph1ghhysr46v9dlyi', '.eJxVjEEOwiAQRe_C2hAdSgdcuu8ZyDBDpWpoUtqV8e7SpAvdvvf-f6tA25rDVtMSJlFXBer0yyLxM5VdyIPKfdY8l3WZot4Tfdiqh1nS63a0fweZam5rtIDiAUDYe49ioTfIfOk6ZBIX0bNjA8kTm0aNa3HPziJKGs9mVJ8vy1c3mA:1q9y6j:bq4MPuqOtyxuWD4AOr2VY7RqjEObkl3Wi4L34W01wCI', '2023-06-30 01:18:33.587962'),
('i07trjq5oh74n3g007ffmztifnxfksom', 'e30:1q9BdJ:toc6sabdHFq-Y1soDet6xy3nFyhFtfg1oaFpkpCB5jM', '2023-06-27 21:32:57.650177'),
('i59ezyvte963zqosfkdve1hb6lqvt5oa', 'e30:1q9BdK:K4-A0Be6bRG91Yh8Izuneo44Y9AULX9hT2z8ljnKa8I', '2023-06-27 21:32:58.078684'),
('il9a4hojyehn495ljpt7cdoxglz1ztq4', 'e30:1q9BdU:9RAzoWYsdCtvtNku6sPLjKi-pcDsch1XC6AA29BgXG8', '2023-06-27 21:33:08.684211'),
('j83py8pb3eae98haakl8fxbi0wc759xo', '.eJxVjEEOwiAQRe_C2hBKmaG4dO8ZyACDVA0kpV0Z765NutDtf-_9l_C0rcVvnRc_J3EWgOL0OwaKD647SXeqtyZjq-syB7kr8qBdXlvi5-Vw_w4K9fKtLSBZBswDUI4qM44OtQU9BVDBmikoQy6gG8dIqJHRkmJ2AzqOyTjx_gD8TzfG:1q9CwJ:fW1_bQ1IQcufANt3TyijN_s7ZoTkicXOhFoPBdr03Mo', '2023-06-27 22:56:39.282256'),
('j8cqun2ocm7kg50vrq3rrrj91yv0l2c5', '.eJxVjDEOgzAQBP_iOrLOxjaQMj1vsO5855gkAglDFeXvAYkiKbbZmd23iritJW5VljiyuiqrLr8dYXrKdAB-4HSfdZqndRlJH4o-adXDzPK6ne7fQcFa9rWjjJ6aZHsDQbqAIDZRFtjjWiAj4H02vTPsWDyLMCTXttIxUhM69fkCBi445g:1qCMfo:1nRrICgSPfPbKW7_ZX2u6LYqf_blK02PPh0CMoAoC4o', '2023-07-06 15:56:40.715476'),
('jf9sz5t15c23k2l3r3ob8g7536sz5e65', 'e30:1q9BdJ:toc6sabdHFq-Y1soDet6xy3nFyhFtfg1oaFpkpCB5jM', '2023-06-27 21:32:57.246181'),
('ji9mx0w91r6d2ijnsbnd1u5oee4wdhud', '.eJxVjEEOgjAQRe_StWk6hU6LS_eeoekwM4IaSCisjHdXEha6_e-9_zK5bOuQtypLHtmcDZjT70alf8i0A76X6Tbbfp7WZSS7K_ag1V5nluflcP8OhlKHb03oRTnE6F10qRHy2mlw1ErHJShi8ARRHWISEHUBqYEWFDghcQPm_QHgcjel:1qCMqf:r6_wsjMkWaJdDXDFAthdCy4ADJKd3QbA-L982tJ_ylg', '2023-07-06 16:07:53.328292'),
('jjtb9r3q2nzuuppkb8sp6pmswt43gmyh', '.eJxVjDsOwjAQBe_iGlnx36ak5wzW7nqDA8iR4qRC3B0ipYD2zcx7iQzbWvPWeclTEWehxel3Q6AHtx2UO7TbLGlu6zKh3BV50C6vc-Hn5XD_Dir0-q2jUQWIDI1pcNYWFQNCcKxHA9FF0CmkSEp5RjNoh9azDUk7hRG8tUq8P9u9Nxc:1q4QZN:yT_rbWUZaZdXm9IMPH1khLiGnCsIonWrGjOG6PC_Ndw', '2023-06-14 18:29:13.884563'),
('lpqfnod2m4riaugu1krb9phzojwzdjs0', '.eJxVjMsOwiAQRf-FtSEMw9Ole7-BAANSNTQp7cr479qkC93ec859sRC3tYVtlCVMxM5MG3b6HVPMj9J3QvfYbzPPc1-XKfFd4Qcd_DpTeV4O9--gxdG-dVJCOfQSLRmowoJwThhp0RupCVOtIgIpDUlLj1izVkRQnQGnI2TB3h_KETax:1qAs7g:pqvBESdhVxgr3FsmuIybcXeokOmz02tg_6txyfi2cU8', '2023-07-02 13:07:16.643128'),
('mds028sqc5di829b61ttbkp7jl1tewng', '.eJxVjE0OwiAYBe_C2hCgQMWl-56BfD8gVQNJaVfGu2uTLnT7Zua9RIRtLXHraYkzi4twXpx-RwR6pLoTvkO9NUmtrsuMclfkQbucGqfn9XD_Dgr08q0DoVYua2awxJkSg0JrMoEiDpQRvbcB7UAqGO8MB6sJxkG5UZ2tSeL9AU0KOOQ:1q9xst:uyG2eLmjP62twwjIv5BOAQ5xrQrxJU_DtyrORrR0WMs', '2023-06-30 01:04:15.237069'),
('n17b86dzf0ryi2bi4tx6zwx6jex7q3ly', '.eJxVjM0OwiAQhN-FsyH8dKH16N1nIMuySNXQpLQn47srSQ96nPm-mZcIuG8l7I3XMCdxFuDF6beMSA-unaQ71tsiaanbOkfZFXnQJq9L4uflcP8OCrbyXRuyYBTxYDNaPWpPHLVzYCx4ML7nKaU4UkSVdc4Kh6QQHLJmPxGK9wcDaTiF:1qB4Oj:5t4_pym15Q67kSGZik3E_aCoFDJVYAAdqMdLBVVRP34', '2023-07-03 02:13:41.231477'),
('n7wnhsfdq77j94axhonl81z7ezbmxx96', '.eJxVjDEOgzAQBP_iOrLOxjaQMj1vsO5855gkAglDFeXvAYkiKbbZmd23iritJW5VljiyuiqrLr8dYXrKdAB-4HSfdZqndRlJH4o-adXDzPK6ne7fQcFa9rWjjJ6aZHsDQbqAIDZRFtjjWiAj4H02vTPsWDyLMCTXttIxUhM69fkCBi445g:1qCdzE:uUDa_ZkHVTtVXD9GG3ayXaZo_k7QU0iSUu_tVEC2UDE', '2023-07-07 10:25:52.697293'),
('ntmpby68zid9ufr02l4mzqvv08tjdkce', 'e30:1q9BdY:oBgmltMLvRk4Ak0DJXK6-mddXZ5n5k2PujGbIcKDYVw', '2023-06-27 21:33:12.505639'),
('o7fs52ykpkujpoxpkdecdrulf5aesxwn', 'e30:1q9Bci:bjEn_S8TZebPIsfNau9tOEWsIrGlc9CHUefjkQA0Fb4', '2023-06-27 21:32:20.369290'),
('o999z0u3gvhh5uq04oq4dzro6373x3wd', 'e30:1q9BdT:PHnmxOWH3W-x3wWwTa00OzvWKle8xxIM03bY241RWA8', '2023-06-27 21:33:07.346433'),
('o9xp2m7u6j0tan1eoyczesl7mat89y18', '.eJxVjEEOwiAQRe_C2hBKmaG4dO8ZyACDVA0kpV0Z765NutDtf-_9l_C0rcVvnRc_J3EWgOL0OwaKD647SXeqtyZjq-syB7kr8qBdXlvi5-Vw_w4K9fKtLSBZBswDUI4qM44OtQU9BVDBmikoQy6gG8dIqJHRkmJ2AzqOyTjx_gD8TzfG:1q9Dvo:itEXergXfpnWUWedK6qh7IPulFgLM9rIHzvD76hdUvo', '2023-06-28 00:00:12.920149'),
('p03yi96swlsuy26vg0xru4htfvdgew9o', 'e30:1q9BdK:K4-A0Be6bRG91Yh8Izuneo44Y9AULX9hT2z8ljnKa8I', '2023-06-27 21:32:58.279218'),
('p8lpih7ogjm094wkb9mfpeh27krw3wd0', 'e30:1q9BdK:K4-A0Be6bRG91Yh8Izuneo44Y9AULX9hT2z8ljnKa8I', '2023-06-27 21:32:58.211214'),
('pbxsprhr9ig4tnupx2zijb1hul7tcpxk', 'e30:1q9BdI:4bW2Rx2b8MXbDz-Ow0MvzIF61q3a9Z1VWuk3NgWkV9Q', '2023-06-27 21:32:56.245882'),
('pp1y9nyh46bnrsk61h2oopawrr1045en', '.eJxVjDsOwjAQBe_iGln-JmtKes5g7a5tHECOFCcV4u4QKQW0b2beS0Tc1hq3npc4JXEWfhCn35GQH7ntJN2x3WbJc1uXieSuyIN2eZ1Tfl4O9--gYq_fGoMGw8ZTDoTZgtcFwCgqA2lkwGD1CBacAxcC45jYEXGCUIxVSSnx_gAM2TgT:1qAsbZ:S6nZnJ1iFYyABJdAH43XMbdG8yriSQpatSZXvpt2ziw', '2023-07-02 13:38:09.167083'),
('ptw32asl0sdyv8l4ly1m8j6ipbg6upz3', '.eJxVjDEOgzAQBP_iOrLOxjaQMj1vsO5855gkAglDFeXvAYkiKbbZmd23iritJW5VljiyuiqrLr8dYXrKdAB-4HSfdZqndRlJH4o-adXDzPK6ne7fQcFa9rWjjJ6aZHsDQbqAIDZRFtjjWiAj4H02vTPsWDyLMCTXttIxUhM69fkCBi445g:1qCNhX:wXvif7Wa3MutbAs3EtS_eiprwPIqXGpNiVv6anBSImY', '2023-07-06 17:02:31.764126'),
('q3vpg1ovmu6lgexnvdqeywdg8aldj0gu', '.eJxVjEEOwiAQRe_C2hBKmaG4dO8ZyACDVA0kpV0Z765NutDtf-_9l_C0rcVvnRc_J3EWgOL0OwaKD647SXeqtyZjq-syB7kr8qBdXlvi5-Vw_w4K9fKtLSBZBswDUI4qM44OtQU9BVDBmikoQy6gG8dIqJHRkmJ2AzqOyTjx_gD8TzfG:1q9EW3:O-kTpzhQpVLShAyblwodPNVWgSpeewSK9rlRM2ZSAVU', '2023-06-28 00:37:39.589420'),
('qbqbrsjhuyyxgtqzw5uma3215rx4tt9e', '.eJxVjEEOwiAQRe_C2hBKmaG4dO8ZyACDVA0kpV0Z765NutDtf-_9l_C0rcVvnRc_J3EWgOL0OwaKD647SXeqtyZjq-syB7kr8qBdXlvi5-Vw_w4K9fKtLSBZBswDUI4qM44OtQU9BVDBmikoQy6gG8dIqJHRkmJ2AzqOyTjx_gD8TzfG:1q9w1m:eQvDoA_yVPhJOXOjzcTcmpq1djMO9VrQBIAabe9-OSA', '2023-06-29 23:05:18.263555'),
('r9gm9oabkv3r06whifuphq8qy2u3uiej', 'e30:1q9BcY:zZLFk6QY-0_LR3621hskpDqnpVtxwtTUg6n5RQOLOFs', '2023-06-27 21:32:10.874743'),
('ruvokphxo6hro7hdkynulx1thq3s5g94', 'e30:1q9BdW:7idEl8i0nYA7vB5viiVdu3H8EMdHKzWIvLDT5d95Szw', '2023-06-27 21:33:10.053528'),
('rzqv1mvaop9t6wth970ep49xusqrc7mj', 'e30:1q9BdK:K4-A0Be6bRG91Yh8Izuneo44Y9AULX9hT2z8ljnKa8I', '2023-06-27 21:32:58.441692'),
('scamj2vihaju2lkpwszopsfyzcjuinh7', 'e30:1q9BdZ:fE8uH0Sif75-S6jh9gaHSgqMYC3poqjipU9Jkbz2IiM', '2023-06-27 21:33:13.475005'),
('t9kokccvd2pidk3ukztipo1zqefh9i6v', 'e30:1q9BdJ:toc6sabdHFq-Y1soDet6xy3nFyhFtfg1oaFpkpCB5jM', '2023-06-27 21:32:57.539552'),
('tmtr2zjgjelcrnciw0va5pcg2coymchl', '.eJxVjEEOgjAQRe_StWk6hU6LS_eeoekwM4IaSCisjHdXEha6_e-9_zK5bOuQtypLHtmcDZjT70alf8i0A76X6Tbbfp7WZSS7K_ag1V5nluflcP8OhlKHb03oRTnE6F10qRHy2mlw1ErHJShi8ARRHWISEHUBqYEWFDghcQPm_QHgcjel:1q4QSZ:uPKYXmFBXD6gJk9YH2vW4GU_LyHqvYBiACL4tdYpkDo', '2023-06-14 18:22:11.010585'),
('u038bysj99kakj4c9o9b9udc3iyffi45', 'e30:1q9BdQ:wzd46PsACUmEVXbmfgEgtf4PoMcKE2-k2iUUQAQtFQw', '2023-06-27 21:33:04.930670'),
('uagfv79jprpm7xrh7t3s3wndsh4bad8e', '.eJxVjDsOwjAQBe_iGln-W6ak5wzWeneDA8iW4qRC3B0ipYD2zcx7iQzbWvM2eMkzibPwQZx-xwL44LYTukO7dYm9rctc5K7Igw557cTPy-H-HVQY9VtPaMBSCsUxEiQbaIoakUkZ0CUygEq2sArJm-iJkwU0zhE4clEHEu8PQyE5Hg:1qBi50:56AaE4njtr60xG5MzteDYEJPvF3CbWhtAOilGH9jRK8', '2023-07-04 20:35:58.319820'),
('up1e9gbbxehishmrugxsin88vje384ed', 'e30:1q9BdV:JyEXsIb9C38AbBUg8ok4Q-oMd1JXALk_wLkqOmprFU8', '2023-06-27 21:33:09.662095'),
('uvsq92xs6jiv809pouqiaqntknrak3za', 'e30:1q9BdT:PHnmxOWH3W-x3wWwTa00OzvWKle8xxIM03bY241RWA8', '2023-06-27 21:33:07.490424'),
('whki122ufrvuopp3v0m1za5f96seeioe', '.eJxVjDsOwjAQBe_iGln-W6ak5wzWeneDA8iW4qRC3B0ipYD2zcx7iQzbWvM2eMkzibPwQZx-xwL44LYTukO7dYm9rctc5K7Igw557cTPy-H-HVQY9VtPaMBSCsUxEiQbaIoakUkZ0CUygEq2sArJm-iJkwU0zhE4clEHEu8PQyE5Hg:1qBiWi:HOAJcgN5hVlgCrUqpcOlz2crWmi7mVgv6AQNB-oICIY', '2023-07-04 21:04:36.910013'),
('wp4ogjkv0fop8rj9lduq5ezz2y6m6yw5', 'e30:1q9BdY:oBgmltMLvRk4Ak0DJXK6-mddXZ5n5k2PujGbIcKDYVw', '2023-06-27 21:33:12.737065'),
('wqviwmsie49g4gvywyvuaznj4ju14fbt', '.eJxVjEEOwiAQRe_C2hBKmaG4dO8ZyACDVA0kpV0Z765NutDtf-_9l_C0rcVvnRc_J3EWgOL0OwaKD647SXeqtyZjq-syB7kr8qBdXlvi5-Vw_w4K9fKtLSBZBswDUI4qM44OtQU9BVDBmikoQy6gG8dIqJHRkmJ2AzqOyTjx_gD8TzfG:1q9EF9:VVGnwz-nxufrfGmuE3eu8h_qbTwTYskSzajEW6iS820', '2023-06-28 00:20:11.573073'),
('x6v694oqnnwokt4jj1frp3et1oe3rh8e', '.eJxVjEEOwiAQRe_C2hBKmaG4dO8ZyACDVA0kpV0Z765NutDtf-_9l_C0rcVvnRc_J3EWgOL0OwaKD647SXeqtyZjq-syB7kr8qBdXlvi5-Vw_w4K9fKtLSBZBswDUI4qM44OtQU9BVDBmikoQy6gG8dIqJHRkmJ2AzqOyTjx_gD8TzfG:1q9Dih:YcvXXuxQbH1HvW3vH-w0uq_vObpGhDQjujX0fUXOrxk', '2023-06-27 23:46:39.975538'),
('xn4waergnuccppxk0mo86svstgp82ars', '.eJxVjDEOgzAQBP_iOrLOxjaQMj1vsO5855gkAglDFeXvAYkiKbbZmd23iritJW5VljiyuiqrLr8dYXrKdAB-4HSfdZqndRlJH4o-adXDzPK6ne7fQcFa9rWjjJ6aZHsDQbqAIDZRFtjjWiAj4H02vTPsWDyLMCTXttIxUhM69fkCBi445g:1qCN5R:DeydM4PPWqUFwgjBNBxXwoT2v6DUgANdQBSyScNvKQw', '2023-07-06 16:23:09.147598'),
('yserfxij5zba623d65ffi322l027tdvw', '.eJxVjM0OwiAQhN-FsyH8dKH16N1nIMuySNXQpLQn47srSQ96nPm-mZcIuG8l7I3XMCdxFuDF6beMSA-unaQ71tsiaanbOkfZFXnQJq9L4uflcP8OCrbyXRuyYBTxYDNaPWpPHLVzYCx4ML7nKaU4UkSVdc4Kh6QQHLJmPxGK9wcDaTiF:1q9mxA:C435hSSUcZgaBo_ukAHXxHDFE3XiSeQ0pfYB3ea0k8g', '2023-06-29 13:23:56.404691'),
('ze13q0wu0uzzuq0agokbp29raset2lz4', '.eJxVjEEOwiAQRe_C2hBKmaG4dO8ZyACDVA0kpV0Z765NutDtf-_9l_C0rcVvnRc_J3EWgOL0OwaKD647SXeqtyZjq-syB7kr8qBdXlvi5-Vw_w4K9fKtLSBZBswDUI4qM44OtQU9BVDBmikoQy6gG8dIqJHRkmJ2AzqOyTjx_gD8TzfG:1q9mIK:wbzqhfsvvi1USxxtDUzmWk-ZN1FWSfdG7-IoXCLQG1E', '2023-06-29 12:41:44.768260'),
('zp6runzu01l7a68de28c4zmiy8pju416', 'e30:1q9BdX:P6K5WjbTxNPyxZUtDCYiGdis2glsBrQlosGLCI4QYO0', '2023-06-27 21:33:11.161516');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `api_ambulance`
--
ALTER TABLE `api_ambulance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `API_ambulance_hospital_id_064bf872_fk_API_hospital_id` (`hospital_id`);

--
-- Indexes for table `api_chatmessage`
--
ALTER TABLE `api_chatmessage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `API_chatmessage_msg_receiver_id_50a29853_fk_API_profile_id` (`msg_receiver_id`),
  ADD KEY `API_chatmessage_msg_sender_id_8e5bc75f_fk_API_profile_id` (`msg_sender_id`);

--
-- Indexes for table `api_firstaid`
--
ALTER TABLE `api_firstaid`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_hospital`
--
ALTER TABLE `api_hospital`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_profile`
--
ALTER TABLE `api_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `api_requesthospital`
--
ALTER TABLE `api_requesthospital`
  ADD PRIMARY KEY (`id`),
  ADD KEY `API_requesthospital_hospital_id_f0ba3644_fk_API_hospital_id` (`hospital_id`);

--
-- Indexes for table `api_tracking`
--
ALTER TABLE `api_tracking`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ambulance_id` (`ambulance_id`),
  ADD UNIQUE KEY `API_tracking_userId_19a023ba_uniq` (`userId`);

--
-- Indexes for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `api_ambulance`
--
ALTER TABLE `api_ambulance`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `api_chatmessage`
--
ALTER TABLE `api_chatmessage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `api_firstaid`
--
ALTER TABLE `api_firstaid`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `api_hospital`
--
ALTER TABLE `api_hospital`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `api_profile`
--
ALTER TABLE `api_profile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `api_requesthospital`
--
ALTER TABLE `api_requesthospital`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `api_tracking`
--
ALTER TABLE `api_tracking`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `api_ambulance`
--
ALTER TABLE `api_ambulance`
  ADD CONSTRAINT `API_ambulance_hospital_id_064bf872_fk_API_hospital_id` FOREIGN KEY (`hospital_id`) REFERENCES `api_hospital` (`id`);

--
-- Constraints for table `api_chatmessage`
--
ALTER TABLE `api_chatmessage`
  ADD CONSTRAINT `API_chatmessage_msg_receiver_id_50a29853_fk_API_profile_id` FOREIGN KEY (`msg_receiver_id`) REFERENCES `api_profile` (`id`),
  ADD CONSTRAINT `API_chatmessage_msg_sender_id_8e5bc75f_fk_API_profile_id` FOREIGN KEY (`msg_sender_id`) REFERENCES `api_profile` (`id`);

--
-- Constraints for table `api_profile`
--
ALTER TABLE `api_profile`
  ADD CONSTRAINT `API_profile_user_id_c37abe66_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `api_requesthospital`
--
ALTER TABLE `api_requesthospital`
  ADD CONSTRAINT `API_requesthospital_hospital_id_f0ba3644_fk_API_hospital_id` FOREIGN KEY (`hospital_id`) REFERENCES `api_hospital` (`id`);

--
-- Constraints for table `api_tracking`
--
ALTER TABLE `api_tracking`
  ADD CONSTRAINT `API_tracking_ambulance_id_18de68a0_fk_API_ambulance_id` FOREIGN KEY (`ambulance_id`) REFERENCES `api_ambulance` (`id`);

--
-- Constraints for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
