:- encoding(utf8).

% ---- model parameters --------------------------------------------
param(train_speed_kmh, 40).
param(dwell_min, 0.5).
param(heuristic_speed_kmh, 80).
param(transfer_same_operator_min, 5).
param(transfer_cross_operator_min, 8).

% ---- line(LineId, Operator) ---------------------------------------
line(bts_sukhumvit, bts).
line(bts_silom, bts).
line(bts_gold, bts).
line(mrt_blue, mrt).
line(mrt_purple, mrt).
line(mrt_yellow, mrt).
line(arl, arl).
line(srt_red_north, srt).
line(srt_red_west, srt).
line(mrt_pink, mrt).
line(mrt_pink_branch, mrt).

% ---- station(Id, NameEn, NameTh, Operator, LineId, Lat, Lng) ------
station(bts_n24, 'Khu Khot', 'คูคต', bts, bts_sukhumvit, 13.932336, 100.646563).
station(bts_n23, 'Yaek Kor Por Aor', 'แยก คปอ.', bts, bts_sukhumvit, 13.924936, 100.625812).
station(bts_n22, 'Royal Thai Air Force Museum', 'พิพิธภัณฑ์กองทัพอากาศ', bts, bts_sukhumvit, 13.917909, 100.621695).
station(bts_n21, 'Bhumibol Adulyadej Hospital', 'โรงพยาบาลภูมิพลอดุลยเดช', bts, bts_sukhumvit, 13.910741, 100.617431).
station(bts_n20, 'Saphan Mai', 'สะพานใหม่', bts, bts_sukhumvit, 13.896587, 100.609137).
station(bts_n19, 'Sai Yud', 'สายหยุด', bts, bts_sukhumvit, 13.888452, 100.604297).
station(bts_n18, 'Phahon Yothin 59', 'พหลโยธิน 59', bts, bts_sukhumvit, 13.882481, 100.600795).
station(bts_n17, 'Wat Phra Sri Mahathat', 'วัดพระศรีมหาธาตุ', bts, bts_sukhumvit, 13.875537, 100.596723).
station(bts_n16, '11th Infantry Regiment', 'กรมทหารราบที่ 11', bts, bts_sukhumvit, 13.867345, 100.591846).
station(bts_n15, 'Bang Bua', 'บางบัว', bts, bts_sukhumvit, 13.855996, 100.585168).
station(bts_n14, 'Royal Forest Department', 'กรมป่าไม้', bts, bts_sukhumvit, 13.850319, 100.581831).
station(bts_n13, 'Kasetsart University', 'มหาวิทยาลัยเกษตรศาสตร์', bts, bts_sukhumvit, 13.842417, 100.577142).
station(bts_n12, 'Sena Nikhom', 'เสนานิคม', bts, bts_sukhumvit, 13.836493, 100.573680).
station(bts_n11, 'Ratchayothin', 'รัชโยธิน', bts, bts_sukhumvit, 13.829859, 100.569770).
station(bts_n10, 'Phahon Yothin 24', 'พหลโยธิน 24', bts, bts_sukhumvit, 13.824244, 100.566478).
station(bts_n9, 'Ha Yaek Lat Phrao', 'ห้าแยกลาดพร้าว', bts, bts_sukhumvit, 13.816415, 100.561961).
station(bts_n8, 'Mo Chit', 'หมอชิต', bts, bts_sukhumvit, 13.802387, 100.553729).
station(bts_n7, 'Saphan Khwai', 'สะพานควาย', bts, bts_sukhumvit, 13.793756, 100.549725).
station(bts_n5, 'Ari', 'อารีย์', bts, bts_sukhumvit, 13.779724, 100.544644).
station(bts_n4, 'Sanam Pao', 'สนามเป้า', bts, bts_sukhumvit, 13.772625, 100.542097).
station(bts_n3, 'Victory Monument', 'อนุสาวรีย์ชัยสมรภูมิ', bts, bts_sukhumvit, 13.762750, 100.537093).
station(bts_n2, 'Phaya Thai', 'พญาไท', bts, bts_sukhumvit, 13.756911, 100.533816).
station(bts_n1, 'Ratchathewi', 'ราชเทวี', bts, bts_sukhumvit, 13.751899, 100.531541).
station(bts_cen, 'Siam', 'สยาม', bts, bts_sukhumvit, 13.745608, 100.534202).
station(bts_e1, 'Chit Lom', 'ชิดลม', bts, bts_sukhumvit, 13.744072, 100.543061).
station(bts_e2, 'Phloen Chit', 'เพลินจิต', bts, bts_sukhumvit, 13.743050, 100.548806).
station(bts_e3, 'Nana', 'นานา', bts, bts_sukhumvit, 13.740527, 100.555443).
station(bts_e4, 'Asok', 'อโศก', bts, bts_sukhumvit, 13.737060, 100.560326).
station(bts_e5, 'Phrom Phong', 'พร้อมพงษ์', bts, bts_sukhumvit, 13.730417, 100.569753).
station(bts_e6, 'Thong Lo', 'ทองหล่อ', bts, bts_sukhumvit, 13.724240, 100.578534).
station(bts_e7, 'Ekkamai', 'เอกมัย', bts, bts_sukhumvit, 13.719580, 100.585072).
station(bts_e8, 'Phra Khanong', 'พระโขนง', bts, bts_sukhumvit, 13.715164, 100.591272).
station(bts_e9, 'On Nut', 'อ่อนนุช', bts, bts_sukhumvit, 13.705604, 100.601031).
station(bts_e10, 'Bang Chak', 'บางจาก', bts, bts_sukhumvit, 13.696783, 100.605373).
station(bts_e11, 'Punnawithi', 'ปุณณวิถี', bts, bts_sukhumvit, 13.689326, 100.609034).
station(bts_e12, 'Udom Suk', 'อุดมสุข', bts, bts_sukhumvit, 13.679871, 100.609485).
station(bts_e13, 'Bang Na', 'บางนา', bts, bts_sukhumvit, 13.668118, 100.604662).
station(bts_e14, 'Bearing', 'แบริ่ง', bts, bts_sukhumvit, 13.661164, 100.601839).
station(bts_e15, 'Samrong', 'สำโรง', bts, bts_sukhumvit, 13.646175, 100.595644).
station(bts_e16, 'Pu Chao', 'ปู่เจ้า', bts, bts_sukhumvit, 13.637456, 100.592021).
station(bts_e17, 'Chang Erawan', 'ช้างเอราวัณ', bts, bts_sukhumvit, 13.621443, 100.590152).
station(bts_e18, 'Royal Thai Naval Academy', 'โรงเรียนนายเรือ', bts, bts_sukhumvit, 13.608594, 100.594852).
station(bts_e19, 'Pak Nam', 'ปากน้ำ', bts, bts_sukhumvit, 13.602066, 100.597099).
station(bts_e20, 'Srinagarindra', 'ศรีนครินทร์', bts, bts_sukhumvit, 13.592138, 100.608929).
station(bts_e21, 'Phraek Sa', 'แพรกษา', bts, bts_sukhumvit, 13.584280, 100.607901).
station(bts_e22, 'Sai Luat', 'สายลวด', bts, bts_sukhumvit, 13.577749, 100.605436).
station(bts_e23, 'Kheha', 'เคหะฯ', bts, bts_sukhumvit, 13.567165, 100.607927).
station(bts_w1, 'National Stadium', 'สนามกีฬาแห่งชาติ', bts, bts_silom, 13.746498, 100.529086).
station(bts_cen_silom, 'Siam', 'สยาม', bts, bts_silom, 13.745608, 100.534202).
station(bts_s1, 'Ratchadamri', 'ราชดำริ', bts, bts_silom, 13.739454, 100.539444).
station(bts_s2, 'Sala Daeng', 'ศาลาแดง', bts, bts_silom, 13.728528, 100.534344).
station(bts_s3, 'Chong Nonsi', 'ช่องนนทรี', bts, bts_silom, 13.723786, 100.529414).
station(bts_s4, 'Saint Louis', 'เซนต์หลุยส์', bts, bts_silom, 13.720741, 100.526644).
station(bts_s5, 'Surasak', 'สุรศักดิ์', bts, bts_silom, 13.719196, 100.521416).
station(bts_s6, 'Saphan Taksin', 'สะพานตากสิน', bts, bts_silom, 13.718802, 100.514145).
station(bts_s7, 'Krung Thon Buri', 'กรุงธนบุรี', bts, bts_silom, 13.720902, 100.502613).
station(bts_s8, 'Wongwian Yai', 'วงเวียนใหญ่', bts, bts_silom, 13.721088, 100.495140).
station(bts_s9, 'Pho Nimit', 'โพธิ์นิมิตร', bts, bts_silom, 13.719229, 100.485926).
station(bts_s10, 'Talat Phlu', 'ตลาดพลู', bts, bts_silom, 13.714217, 100.476693).
station(bts_s11, 'Wutthakat', 'วุฒากาศ', bts, bts_silom, 13.713028, 100.469020).
station(bts_s12, 'Bang Wa', 'บางหว้า', bts, bts_silom, 13.720767, 100.457836).
station(bts_g1, 'Krung Thon Buri', 'กรุงธนบุรี', bts, bts_gold, 13.720902, 100.502613).
station(bts_g2, 'Charoen Nakhon', 'เจริญนคร', bts, bts_gold, 13.726464, 100.509036).
station(bts_g3, 'Khlong San', 'คลองสาน', bts, bts_gold, 13.730339, 100.507693).
station(mrt_bl01, 'Tha Phra', 'ท่าพระ', mrt, mrt_blue, 13.729326, 100.474235).
station(mrt_bl02, 'Charan 13', 'จรัญฯ 13', mrt, mrt_blue, 13.740068, 100.470867).
station(mrt_bl03, 'Fai Chai', 'ไฟฉาย', mrt, mrt_blue, 13.755217, 100.469495).
station(mrt_bl04, 'Bang Khun Non', 'บางขุนนนท์', mrt, mrt_blue, 13.763116, 100.473362).
station(mrt_bl05, 'Bang Yi Khan', 'บางยี่ขัน', mrt, mrt_blue, 13.777411, 100.485373).
station(mrt_bl06, 'Sirindhorn', 'สิรินธร', mrt, mrt_blue, 13.783618, 100.492985).
station(mrt_bl07, 'Bang Phlat', 'บางพลัด', mrt, mrt_blue, 13.792338, 100.504835).
station(mrt_bl08, 'Bang O', 'บางอ้อ', mrt, mrt_blue, 13.798859, 100.509737).
station(mrt_bl09, 'Bang Pho', 'บางโพ', mrt, mrt_blue, 13.806364, 100.521020).
station(mrt_bl10, 'Tao Poon', 'เตาปูน', mrt, mrt_blue, 13.806130, 100.530798).
station(mrt_bl11, 'Bang Sue', 'บางซื่อ', mrt, mrt_blue, 13.802981, 100.539137).
station(mrt_bl12, 'Kamphaeng Phet', 'กำแพงเพชร', mrt, mrt_blue, 13.797776, 100.548171).
station(mrt_bl13, 'Chatuchak Park', 'สวนจตุจักร', mrt, mrt_blue, 13.802766, 100.553750).
station(mrt_bl14, 'Phahon Yothin', 'พหลโยธิน', mrt, mrt_blue, 13.813152, 100.560902).
station(mrt_bl15, 'Lat Phrao', 'ลาดพร้าว', mrt, mrt_blue, 13.806454, 100.572912).
station(mrt_bl16, 'Ratchadaphisek', 'รัชดาภิเษก', mrt, mrt_blue, 13.798852, 100.574601).
station(mrt_bl17, 'Sutthisan', 'สุทธิสาร', mrt, mrt_blue, 13.790071, 100.574128).
station(mrt_bl18, 'Huai Khwang', 'ห้วยขวาง', mrt, mrt_blue, 13.778672, 100.573579).
station(mrt_bl19, 'Thailand Cultural Centre', 'ศูนย์วัฒนธรรมแห่งประเทศไทย', mrt, mrt_blue, 13.766350, 100.570443).
station(mrt_bl20, 'Phra Ram 9', 'พระราม 9', mrt, mrt_blue, 13.757346, 100.565300).
station(mrt_bl21, 'Phetchaburi', 'เพชรบุรี', mrt, mrt_blue, 13.749330, 100.563489).
station(mrt_bl22, 'Sukhumvit', 'สุขุมวิท', mrt, mrt_blue, 13.737668, 100.561469).
station(mrt_bl23, 'Queen Sirikit National Convention Centre', 'ศูนย์การประชุมแห่งชาติสิริกิติ์', mrt, mrt_blue, 13.722941, 100.559697).
station(mrt_bl24, 'Khlong Toei', 'คลองเตย', mrt, mrt_blue, 13.722292, 100.553985).
station(mrt_bl25, 'Lumphini', 'ลุมพินี', mrt, mrt_blue, 13.725411, 100.546500).
station(mrt_bl26, 'Si Lom', 'สีลม', mrt, mrt_blue, 13.729364, 100.537352).
station(mrt_bl27, 'Sam Yan', 'สามย่าน', mrt, mrt_blue, 13.732498, 100.529427).
station(mrt_bl28, 'Hua Lamphong', 'หัวลำโพง', mrt, mrt_blue, 13.737621, 100.517112).
station(mrt_bl29, 'Wat Mangkon', 'วัดมังกร', mrt, mrt_blue, 13.742316, 100.509686).
station(mrt_bl30, 'Sam Yot', 'สามยอด', mrt, mrt_blue, 13.746941, 100.503168).
station(mrt_bl31, 'Sanam Chai', 'สนามไชย', mrt, mrt_blue, 13.743463, 100.494805).
station(mrt_bl32, 'Itsaraphap', 'อิสรภาพ', mrt, mrt_blue, 13.739286, 100.484595).
station(mrt_bl33, 'Bang Phai', 'บางไผ่', mrt, mrt_blue, 13.724608, 100.465250).
station(mrt_bl34, 'Bang Wa', 'บางหว้า', mrt, mrt_blue, 13.720767, 100.457836).
station(mrt_bl35, 'Phetkasem 48', 'เพชรเกษม 48', mrt, mrt_blue, 13.715440, 100.445606).
station(mrt_bl36, 'Phasi Charoen', 'ภาษีเจริญ', mrt, mrt_blue, 13.712934, 100.434409).
station(mrt_bl37, 'Bang Khae', 'บางแค', mrt, mrt_blue, 13.712083, 100.422861).
station(mrt_bl38, 'Lak Song', 'หลักสอง', mrt, mrt_blue, 13.710851, 100.409520).
station(mrt_pp01, 'Khlong Bang Phai', 'คลองบางไผ่', mrt, mrt_purple, 13.892498, 100.408265).
station(mrt_pp02, 'Talad Bang Yai', 'ตลาดบางใหญ่', mrt, mrt_purple, 13.881153, 100.409279).
station(mrt_pp03, 'Sam Yaek Bang Yai', 'สามแยกบางใหญ่', mrt, mrt_purple, 13.874732, 100.419364).
station(mrt_pp04, 'Bang Phlu', 'บางพลู', mrt, mrt_purple, 13.875848, 100.433784).
station(mrt_pp05, 'Bang Rak Yai', 'บางรักใหญ่', mrt, mrt_purple, 13.876679, 100.444917).
station(mrt_pp06, 'Bang Rak Noi Tha It', 'บางรักน้อยท่าอิฐ', mrt, mrt_purple, 13.874895, 100.455992).
station(mrt_pp07, 'Sai Ma', 'ไทรม้า', mrt, mrt_purple, 13.870481, 100.466682).
station(mrt_pp08, 'Phra Nang Klao Bridge', 'สะพานพระนั่งเกล้า', mrt, mrt_purple, 13.870319, 100.480239).
station(mrt_pp09, 'Yaek Nonthaburi 1', 'แยกนนทบุรี 1', mrt, mrt_purple, 13.865955, 100.494256).
station(mrt_pp10, 'Bang Krasor', 'บางกระสอ', mrt, mrt_purple, 13.861650, 100.504659).
station(mrt_pp11, 'Nonthaburi Civic Center', 'ศูนย์ราชการนนทบุรี', mrt, mrt_purple, 13.860189, 100.512994).
station(mrt_pp12, 'Ministry of Public Health', 'กระทรวงสาธารณสุข', mrt, mrt_purple, 13.848482, 100.514724).
station(mrt_pp13, 'Yaek Tiwanon', 'แยกติวานนท์', mrt, mrt_purple, 13.839543, 100.514973).
station(mrt_pp14, 'Wong Sawang', 'วงศ์สว่าง', mrt, mrt_purple, 13.829816, 100.526499).
station(mrt_pp15, 'Bang Son', 'บางซ่อน', mrt, mrt_purple, 13.820054, 100.532427).
station(mrt_pp16, 'Tao Poon', 'เตาปูน', mrt, mrt_purple, 13.806130, 100.530798).
station(mrt_yl01, 'Lat Phrao', 'ลาดพร้าว', mrt, mrt_yellow, 13.806662, 100.574864).
station(mrt_yl02, 'Phawana', 'ภาวนา', mrt, mrt_yellow, 13.800128, 100.584246).
station(mrt_yl03, 'Chok Chai 4', 'โชคชัย 4', mrt, mrt_yellow, 13.794447, 100.594390).
station(mrt_yl04, 'Lat Phrao 71', 'ลาดพร้าว 71', mrt, mrt_yellow, 13.787319, 100.607145).
station(mrt_yl05, 'Lat Phrao 83', 'ลาดพร้าว 83', mrt, mrt_yellow, 13.783674, 100.613735).
station(mrt_yl06, 'Mahat Thai', 'มหาดไทย', mrt, mrt_yellow, 13.778072, 100.623710).
station(mrt_yl07, 'Lat Phrao 101', 'ลาดพร้าว 101', mrt, mrt_yellow, 13.774367, 100.630377).
station(mrt_yl08, 'Bang Kapi', 'บางกะปิ', mrt, mrt_yellow, 13.769007, 100.639852).
station(mrt_yl09, 'Yaek Lam Sali', 'แยกลำสาลี', mrt, mrt_yellow, 13.761953, 100.645582).
station(mrt_yl10, 'Si Kritha', 'ศรีกรีฑา', mrt, mrt_yellow, 13.750904, 100.644912).
station(mrt_yl11, 'Hua Mak', 'หัวหมาก', mrt, mrt_yellow, 13.736555, 100.641442).
station(mrt_yl12, 'Kalantan', 'กลันตัน', mrt, mrt_yellow, 13.725633, 100.641774).
station(mrt_yl13, 'Si Nut', 'ศรีนุช', mrt, mrt_yellow, 13.711086, 100.644175).
station(mrt_yl14, 'Srinagarindra 38', 'ศรีนครินทร์ 38', mrt, mrt_yellow, 13.700619, 100.646605).
station(mrt_yl15, 'Suan Luang Rama IX', 'สวนหลวง ร.9', mrt, mrt_yellow, 13.690800, 100.647125).
station(mrt_yl16, 'Si Udom', 'ศรีอุดม', mrt, mrt_yellow, 13.676549, 100.646164).
station(mrt_yl17, 'Si Iam', 'ศรีเอี่ยม', mrt, mrt_yellow, 13.667691, 100.645219).
station(mrt_yl18, 'Si La Salle', 'ศรีลาซาล', mrt, mrt_yellow, 13.655010, 100.642024).
station(mrt_yl19, 'Si Bearing', 'ศรีแบริ่ง', mrt, mrt_yellow, 13.643577, 100.636307).
station(mrt_yl20, 'Si Dan', 'ศรีด่าน', mrt, mrt_yellow, 13.633102, 100.630151).
station(mrt_yl21, 'Si Thepha', 'ศรีเทพา', mrt, mrt_yellow, 13.629992, 100.622556).
station(mrt_yl22, 'Thipphawan', 'ทิพวัล', mrt, mrt_yellow, 13.636685, 100.609928).
station(mrt_yl23, 'Samrong', 'สำโรง', mrt, mrt_yellow, 13.646175, 100.595644).
station(arl_a8, 'Phaya Thai', 'พญาไท', arl, arl, 13.756911, 100.533816).
station(arl_a7, 'Ratchaprarop', 'ราชปรารภ', arl, arl, 13.754884, 100.542179).
station(arl_a6, 'Makkasan', 'มักกะสัน', arl, arl, 13.750833, 100.561225).
station(arl_a5, 'Ramkhamhaeng', 'รามคำแหง', arl, arl, 13.742942, 100.600056).
station(arl_a4, 'Hua Mak', 'หัวหมาก', arl, arl, 13.737924, 100.644823).
station(arl_a3, 'Ban Thap Chang', 'บ้านทับช้าง', arl, arl, 13.732799, 100.690751).
station(arl_a2, 'Lat Krabang', 'ลาดกระบัง', arl, arl, 13.727635, 100.748424).
station(arl_a1, 'Suvarnabhumi', 'สุวรรณภูมิ', arl, arl, 13.694134, 100.751265).
station(srt_rn00, 'Krung Thep Aphiwat', 'กรุงเทพอภิวัฒน์', srt, srt_red_north, 13.804696, 100.541767).
station(srt_rn01, 'Chatuchak', 'จตุจักร', srt, srt_red_north, 13.826238, 100.549461).
station(srt_rn02, 'Wat Samian Nari', 'วัดเสมียนนารี', srt, srt_red_north, 13.841712, 100.557651).
station(srt_rn03, 'Bang Khen', 'บางเขน', srt, srt_red_north, 13.849454, 100.561745).
station(srt_rn04, 'Thung Song Hong', 'ทุ่งสองห้อง', srt, srt_red_north, 13.860103, 100.567476).
station(srt_rn05, 'Lak Si', 'หลักสี่', srt, srt_red_north, 13.886348, 100.581842).
station(srt_rn06, 'Kan Kheha', 'การเคหะฯ', srt, srt_red_north, 13.898446, 100.588770).
station(srt_rn07, 'Don Mueang', 'ดอนเมือง', srt, srt_red_north, 13.914777, 100.597915).
station(srt_rn08, 'Lak Hok', 'หลักหก', srt, srt_red_north, 13.965833, 100.605341).
station(srt_rn09, 'Rangsit', 'รังสิต', srt, srt_red_north, 13.990512, 100.602197).
station(srt_rw01, 'Bang Son', 'บางซ่อน', srt, srt_red_west, 13.822116, 100.534240).
station(srt_rw02, 'Bang Bamru', 'บางบำหรุ', srt, srt_red_west, 13.792183, 100.477442).
station(srt_rw03, 'Taling Chan', 'ตลิ่งชัน', srt, srt_red_west, 13.789244, 100.440084).
station(mrt_pk01, 'Nonthaburi Civic Center', 'ศูนย์ราชการนนทบุรี', mrt, mrt_pink, 13.860189, 100.512994).
station(mrt_pk02, 'Khae Rai', 'แคราย', mrt, mrt_pink, 13.862716, 100.520603).
station(mrt_pk03, 'Sanambin Nam', 'สนามบินน้ำ', mrt, mrt_pink, 13.874067, 100.516327).
station(mrt_pk04, 'Samakkhi', 'สามัคคี', mrt, mrt_pink, 13.889284, 100.510566).
station(mrt_pk05, 'Royal Irrigation Department', 'กรมชลประทาน', mrt, mrt_pink, 13.898511, 100.507092).
station(mrt_pk06, 'Yaek Pak Kret', 'แยกปากเกร็ด', mrt, mrt_pink, 13.906294, 100.505413).
station(mrt_pk07, 'Pak Kret Bypass', 'เลี่ยงเมืองปากเกร็ด', mrt, mrt_pink, 13.906535, 100.515537).
station(mrt_pk08, 'Chaeng Watthana-Pak Kret 28', 'แจ้งวัฒนะ-ปากเกร็ด 28', mrt, mrt_pink, 13.904198, 100.529250).
station(mrt_pk09, 'Si Rat', 'ศรีรัช', mrt, mrt_pink, 13.900584, 100.539987).
station(mrt_pk10, 'Muang Thong Thani', 'เมืองทองธานี', mrt, mrt_pink, 13.897447, 100.548370).
station(mrt_pk11, 'Chaeng Watthana 14', 'แจ้งวัฒนะ 14', mrt, mrt_pink, 13.893309, 100.560093).
station(mrt_pk12, 'Government Complex', 'ศูนย์ราชการเฉลิมพระเกียรติ', mrt, mrt_pink, 13.890780, 100.567307).
station(mrt_pk13, 'National Telecom', 'โทรคมนาคมแห่งชาติ', mrt, mrt_pink, 13.887577, 100.575603).
station(mrt_pk14, 'Lak Si', 'หลักสี่', mrt, mrt_pink, 13.884158, 100.582603).
station(mrt_pk15, 'Rajabhat Phranakhon', 'ราชภัฏพระนคร', mrt, mrt_pink, 13.879922, 100.589274).
station(mrt_pk16, 'Wat Phra Sri Mahathat', 'วัดพระศรีมหาธาตุ', mrt, mrt_pink, 13.874840, 100.597075).
station(mrt_pk17, 'Ram Inthra 3', 'รามอินทรา 3', mrt, mrt_pink, 13.870956, 100.602559).
station(mrt_pk18, 'Lat Pla Khao', 'ลาดปลาเค้า', mrt, mrt_pink, 13.862806, 100.617756).
station(mrt_pk19, 'Ram Inthra Kor Mor 4', 'รามอินทรา กม.4', mrt, mrt_pink, 13.858332, 100.626058).
station(mrt_pk20, 'Maiyalap', 'มัยลาภ', mrt, mrt_pink, 13.854999, 100.632243).
station(mrt_pk21, 'Vacharaphol', 'วัชรพล', mrt, mrt_pink, 13.849265, 100.642834).
station(mrt_pk22, 'Ram Inthra Kor Mor 6', 'รามอินทรา กม.6', mrt, mrt_pink, 13.845208, 100.650194).
station(mrt_pk23, 'Khu Bon', 'คู้บอน', mrt, mrt_pink, 13.840549, 100.658763).
station(mrt_pk24, 'Ram Inthra Kor Mor 9', 'รามอินทรา กม.9', mrt, mrt_pink, 13.833788, 100.667454).
station(mrt_pk25, 'Outer Ring Road-Ram Inthra', 'วงแหวนรามอินทรา', mrt, mrt_pink, 13.824482, 100.677067).
station(mrt_pk26, 'Nopparat', 'นพรัตน์', mrt, mrt_pink, 13.816551, 100.685494).
station(mrt_pk27, 'Bang Chan', 'บางชัน', mrt, mrt_pink, 13.812720, 100.702792).
station(mrt_pk28, 'Setthabutbamphen', 'เศรษฐบุตรบำเพ็ญ', mrt, mrt_pink, 13.812683, 100.712480).
station(mrt_pk29, 'Min Buri Market', 'ตลาดมีนบุรี', mrt, mrt_pink, 13.812514, 100.725687).
station(mrt_pk30, 'Min Buri', 'มีนบุรี', mrt, mrt_pink, 13.808439, 100.732560).
station(mrt_mt01, 'Impact Muang Thong Thani', 'อิมแพ็ค เมืองทองธานี', mrt, mrt_pink_branch, 13.910901, 100.544326).
station(mrt_mt02, 'Lake Muang Thong Thani', 'ทะเลสาบเมืองทองธานี', mrt, mrt_pink_branch, 13.918305, 100.545651).

% ---- verified(Id): coordinates marked verified in the source data -
verified(mrt_yl01).
verified(mrt_yl02).
verified(mrt_yl03).
verified(mrt_yl04).
verified(mrt_yl05).
verified(mrt_yl06).
verified(mrt_yl07).
verified(mrt_yl08).
verified(mrt_yl09).
verified(mrt_yl10).
verified(mrt_yl11).
verified(mrt_yl12).
verified(mrt_yl13).
verified(mrt_yl14).
verified(mrt_yl15).
verified(mrt_yl16).
verified(mrt_yl17).
verified(mrt_yl18).
verified(mrt_yl19).
verified(mrt_yl20).
verified(arl_a4).
verified(mrt_pk21).
verified(mrt_pk22).

% ---- edge(From, To, Minutes): one fact per direction ---------------
edge(bts_n24, bts_n23, 4.079).
edge(bts_n23, bts_n24, 4.079).
edge(bts_n23, bts_n22, 1.849).
edge(bts_n22, bts_n23, 1.849).
edge(bts_n22, bts_n21, 1.880).
edge(bts_n21, bts_n22, 1.880).
edge(bts_n21, bts_n20, 3.216).
edge(bts_n20, bts_n21, 3.216).
edge(bts_n20, bts_n19, 2.067).
edge(bts_n19, bts_n20, 2.067).
edge(bts_n19, bts_n18, 1.646).
edge(bts_n18, bts_n19, 1.646).
edge(bts_n18, bts_n17, 1.832).
edge(bts_n17, bts_n18, 1.832).
edge(bts_n17, bts_n16, 2.078).
edge(bts_n16, bts_n17, 2.078).
edge(bts_n16, bts_n15, 2.679).
edge(bts_n15, bts_n16, 2.679).
edge(bts_n15, bts_n14, 1.591).
edge(bts_n14, bts_n15, 1.591).
edge(bts_n14, bts_n13, 2.021).
edge(bts_n13, bts_n14, 2.021).
edge(bts_n13, bts_n12, 1.635).
edge(bts_n12, bts_n13, 1.635).
edge(bts_n12, bts_n11, 1.775).
edge(bts_n11, bts_n12, 1.775).
edge(bts_n11, bts_n10, 1.577).
edge(bts_n10, bts_n11, 1.577).
edge(bts_n10, bts_n9, 1.997).
edge(bts_n9, bts_n10, 1.997).
edge(bts_n9, bts_n8, 3.192).
edge(bts_n8, bts_n9, 3.192).
edge(bts_n8, bts_n7, 2.079).
edge(bts_n7, bts_n8, 2.079).
edge(bts_n7, bts_n5, 2.981).
edge(bts_n5, bts_n7, 2.981).
edge(bts_n5, bts_n4, 1.754).
edge(bts_n4, bts_n5, 1.754).
edge(bts_n4, bts_n3, 2.336).
edge(bts_n3, bts_n4, 2.336).
edge(bts_n3, bts_n2, 1.608).
edge(bts_n2, bts_n3, 1.608).
edge(bts_n2, bts_n1, 1.413).
edge(bts_n1, bts_n2, 1.413).
edge(bts_n1, bts_cen, 1.634).
edge(bts_cen, bts_n1, 1.634).
edge(bts_cen, bts_e1, 1.958).
edge(bts_e1, bts_cen, 1.958).
edge(bts_e1, bts_e2, 1.446).
edge(bts_e2, bts_e1, 1.446).
edge(bts_e2, bts_e3, 1.655).
edge(bts_e3, bts_e2, 1.655).
edge(bts_e3, bts_e4, 1.479).
edge(bts_e4, bts_e3, 1.479).
edge(bts_e4, bts_e5, 2.387).
edge(bts_e5, bts_e4, 2.387).
edge(bts_e5, bts_e6, 2.256).
edge(bts_e6, bts_e5, 2.256).
edge(bts_e6, bts_e7, 1.814).
edge(bts_e7, bts_e6, 1.814).
edge(bts_e7, bts_e8, 1.745).
edge(bts_e8, bts_e7, 1.745).
edge(bts_e8, bts_e9, 2.745).
edge(bts_e9, bts_e8, 2.745).
edge(bts_e9, bts_e10, 2.130).
edge(bts_e10, bts_e9, 2.130).
edge(bts_e10, bts_e11, 1.879).
edge(bts_e11, bts_e10, 1.879).
edge(bts_e11, bts_e12, 2.078).
edge(bts_e12, bts_e11, 2.078).
edge(bts_e12, bts_e13, 2.611).
edge(bts_e13, bts_e12, 2.611).
edge(bts_e13, bts_e14, 1.746).
edge(bts_e14, bts_e13, 1.746).
edge(bts_e14, bts_e15, 3.194).
edge(bts_e15, bts_e14, 3.194).
edge(bts_e15, bts_e16, 2.069).
edge(bts_e16, bts_e15, 2.069).
edge(bts_e16, bts_e17, 3.188).
edge(bts_e17, bts_e16, 3.188).
edge(bts_e17, bts_e18, 2.774).
edge(bts_e18, bts_e17, 2.774).
edge(bts_e18, bts_e19, 1.647).
edge(bts_e19, bts_e18, 1.647).
edge(bts_e19, bts_e20, 3.034).
edge(bts_e20, bts_e19, 3.034).
edge(bts_e20, bts_e21, 1.821).
edge(bts_e21, bts_e20, 1.821).
edge(bts_e21, bts_e22, 1.661).
edge(bts_e22, bts_e21, 1.661).
edge(bts_e22, bts_e23, 2.311).
edge(bts_e23, bts_e22, 2.311).
edge(bts_w1, bts_cen_silom, 1.341).
edge(bts_cen_silom, bts_w1, 1.341).
edge(bts_cen_silom, bts_s1, 1.832).
edge(bts_s1, bts_cen_silom, 1.832).
edge(bts_s1, bts_s2, 2.501).
edge(bts_s2, bts_s1, 2.501).
edge(bts_s2, bts_s3, 1.623).
edge(bts_s3, bts_s2, 1.623).
edge(bts_s3, bts_s4, 1.178).
edge(bts_s4, bts_s3, 1.178).
edge(bts_s4, bts_s5, 1.385).
edge(bts_s5, bts_s4, 1.385).
edge(bts_s5, bts_s6, 1.681).
edge(bts_s6, bts_s5, 1.681).
edge(bts_s6, bts_s7, 2.400).
edge(bts_s7, bts_s6, 2.400).
edge(bts_s7, bts_s8, 1.712).
edge(bts_s8, bts_s7, 1.712).
edge(bts_s8, bts_s9, 2.026).
edge(bts_s9, bts_s8, 2.026).
edge(bts_s9, bts_s10, 2.215).
edge(bts_s10, bts_s9, 2.215).
edge(bts_s10, bts_s11, 1.758).
edge(bts_s11, bts_s10, 1.758).
edge(bts_s11, bts_s12, 2.725).
edge(bts_s12, bts_s11, 2.725).
edge(bts_g1, bts_g2, 1.894).
edge(bts_g2, bts_g1, 1.894).
edge(bts_g2, bts_g3, 1.183).
edge(bts_g3, bts_g2, 1.183).
edge(mrt_bl01, mrt_bl02, 2.373).
edge(mrt_bl02, mrt_bl01, 2.373).
edge(mrt_bl02, mrt_bl03, 3.037).
edge(mrt_bl03, mrt_bl02, 3.037).
edge(mrt_bl03, mrt_bl04, 1.960).
edge(mrt_bl04, mrt_bl03, 1.960).
edge(mrt_bl04, mrt_bl05, 3.578).
edge(mrt_bl05, mrt_bl04, 3.578).
edge(mrt_bl05, mrt_bl06, 2.109).
edge(mrt_bl06, mrt_bl05, 2.109).
edge(mrt_bl06, mrt_bl07, 2.909).
edge(mrt_bl07, mrt_bl06, 2.909).
edge(mrt_bl07, mrt_bl08, 1.847).
edge(mrt_bl08, mrt_bl07, 1.847).
edge(mrt_bl08, mrt_bl09, 2.716).
edge(mrt_bl09, mrt_bl08, 2.716).
edge(mrt_bl09, mrt_bl10, 2.084).
edge(mrt_bl10, mrt_bl09, 2.084).
edge(mrt_bl10, mrt_bl11, 1.949).
edge(mrt_bl11, mrt_bl10, 1.949).
edge(mrt_bl11, mrt_bl12, 2.201).
edge(mrt_bl12, mrt_bl11, 2.201).
edge(mrt_bl12, mrt_bl13, 1.728).
edge(mrt_bl13, mrt_bl12, 1.728).
edge(mrt_bl13, mrt_bl14, 2.583).
edge(mrt_bl14, mrt_bl13, 2.583).
edge(mrt_bl14, mrt_bl15, 2.744).
edge(mrt_bl15, mrt_bl14, 2.744).
edge(mrt_bl15, mrt_bl16, 1.797).
edge(mrt_bl16, mrt_bl15, 1.797).
edge(mrt_bl16, mrt_bl17, 1.967).
edge(mrt_bl17, mrt_bl16, 1.967).
edge(mrt_bl17, mrt_bl18, 2.403).
edge(mrt_bl18, mrt_bl17, 2.403).
edge(mrt_bl18, mrt_bl19, 2.617).
edge(mrt_bl19, mrt_bl18, 2.617).
edge(mrt_bl19, mrt_bl20, 2.218).
edge(mrt_bl20, mrt_bl19, 2.218).
edge(mrt_bl20, mrt_bl21, 1.870).
edge(mrt_bl21, mrt_bl20, 1.870).
edge(mrt_bl21, mrt_bl22, 2.473).
edge(mrt_bl22, mrt_bl21, 2.473).
edge(mrt_bl22, mrt_bl23, 2.974).
edge(mrt_bl23, mrt_bl22, 2.974).
edge(mrt_bl23, mrt_bl24, 1.431).
edge(mrt_bl24, mrt_bl23, 1.431).
edge(mrt_bl24, mrt_bl25, 1.820).
edge(mrt_bl25, mrt_bl24, 1.820).
edge(mrt_bl25, mrt_bl26, 2.123).
edge(mrt_bl26, mrt_bl25, 2.123).
edge(mrt_bl26, mrt_bl27, 1.886).
edge(mrt_bl27, mrt_bl26, 1.886).
edge(mrt_bl27, mrt_bl28, 2.671).
edge(mrt_bl28, mrt_bl27, 2.671).
edge(mrt_bl28, mrt_bl29, 1.935).
edge(mrt_bl29, mrt_bl28, 1.935).
edge(mrt_bl29, mrt_bl30, 1.808).
edge(mrt_bl30, mrt_bl29, 1.808).
edge(mrt_bl30, mrt_bl31, 1.974).
edge(mrt_bl31, mrt_bl30, 1.974).
edge(mrt_bl31, mrt_bl32, 2.296).
edge(mrt_bl32, mrt_bl31, 2.296).
edge(mrt_bl33, mrt_bl34, 1.862).
edge(mrt_bl34, mrt_bl33, 1.862).
edge(mrt_bl34, mrt_bl35, 2.672).
edge(mrt_bl35, mrt_bl34, 2.672).
edge(mrt_bl35, mrt_bl36, 2.362).
edge(mrt_bl36, mrt_bl35, 2.362).
edge(mrt_bl36, mrt_bl37, 2.377).
edge(mrt_bl37, mrt_bl36, 2.377).
edge(mrt_bl37, mrt_bl38, 2.672).
edge(mrt_bl38, mrt_bl37, 2.672).
edge(mrt_pp01, mrt_pp02, 2.399).
edge(mrt_pp02, mrt_pp01, 2.399).
edge(mrt_pp02, mrt_pp03, 2.453).
edge(mrt_pp03, mrt_pp02, 2.453).
edge(mrt_pp03, mrt_pp04, 2.843).
edge(mrt_pp04, mrt_pp03, 2.843).
edge(mrt_pp04, mrt_pp05, 2.308).
edge(mrt_pp05, mrt_pp04, 2.308).
edge(mrt_pp05, mrt_pp06, 2.318).
edge(mrt_pp06, mrt_pp05, 2.318).
edge(mrt_pp06, mrt_pp07, 2.381).
edge(mrt_pp07, mrt_pp06, 2.381).
edge(mrt_pp07, mrt_pp08, 2.696).
edge(mrt_pp08, mrt_pp07, 2.696).
edge(mrt_pp08, mrt_pp09, 2.883).
edge(mrt_pp09, mrt_pp08, 2.883).
edge(mrt_pp09, mrt_pp10, 2.332).
edge(mrt_pp10, mrt_pp09, 2.332).
edge(mrt_pp10, mrt_pp11, 1.871).
edge(mrt_pp11, mrt_pp10, 1.871).
edge(mrt_pp11, mrt_pp12, 2.473).
edge(mrt_pp12, mrt_pp11, 2.473).
edge(mrt_pp12, mrt_pp13, 1.991).
edge(mrt_pp13, mrt_pp12, 1.991).
edge(mrt_pp13, mrt_pp14, 2.974).
edge(mrt_pp14, mrt_pp13, 2.974).
edge(mrt_pp14, mrt_pp15, 2.390).
edge(mrt_pp15, mrt_pp14, 2.390).
edge(mrt_pp15, mrt_pp16, 2.837).
edge(mrt_pp16, mrt_pp15, 2.837).
edge(mrt_yl01, mrt_yl02, 2.370).
edge(mrt_yl02, mrt_yl01, 2.370).
edge(mrt_yl02, mrt_yl03, 2.397).
edge(mrt_yl03, mrt_yl02, 2.397).
edge(mrt_yl03, mrt_yl04, 2.883).
edge(mrt_yl04, mrt_yl03, 2.883).
edge(mrt_yl04, mrt_yl05, 1.728).
edge(mrt_yl05, mrt_yl04, 1.728).
edge(mrt_yl05, mrt_yl06, 2.366).
edge(mrt_yl06, mrt_yl05, 2.366).
edge(mrt_yl06, mrt_yl07, 1.745).
edge(mrt_yl07, mrt_yl06, 1.745).
edge(mrt_yl07, mrt_yl08, 2.276).
edge(mrt_yl08, mrt_yl07, 2.276).
edge(mrt_yl08, mrt_yl09, 1.998).
edge(mrt_yl09, mrt_yl08, 1.998).
edge(mrt_yl09, mrt_yl10, 2.347).
edge(mrt_yl10, mrt_yl09, 2.347).
edge(mrt_yl10, mrt_yl11, 2.958).
edge(mrt_yl11, mrt_yl10, 2.958).
edge(mrt_yl11, mrt_yl12, 2.323).
edge(mrt_yl12, mrt_yl11, 2.323).
edge(mrt_yl12, mrt_yl13, 2.957).
edge(mrt_yl13, mrt_yl12, 2.957).
edge(mrt_yl13, mrt_yl14, 2.290).
edge(mrt_yl14, mrt_yl13, 2.290).
edge(mrt_yl14, mrt_yl15, 2.139).
edge(mrt_yl15, mrt_yl14, 2.139).
edge(mrt_yl15, mrt_yl16, 2.882).
edge(mrt_yl16, mrt_yl15, 2.882).
edge(mrt_yl16, mrt_yl17, 1.985).
edge(mrt_yl17, mrt_yl16, 1.985).
edge(mrt_yl17, mrt_yl18, 2.678).
edge(mrt_yl18, mrt_yl17, 2.678).
edge(mrt_yl18, mrt_yl19, 2.619).
edge(mrt_yl19, mrt_yl18, 2.619).
edge(mrt_yl19, mrt_yl20, 2.511).
edge(mrt_yl20, mrt_yl19, 2.511).
edge(mrt_yl20, mrt_yl21, 1.837).
edge(mrt_yl21, mrt_yl20, 1.837).
edge(mrt_yl21, mrt_yl22, 2.831).
edge(mrt_yl22, mrt_yl21, 2.831).
edge(mrt_yl22, mrt_yl23, 3.305).
edge(mrt_yl23, mrt_yl22, 3.305).
edge(arl_a8, arl_a7, 1.897).
edge(arl_a7, arl_a8, 1.897).
edge(arl_a7, arl_a6, 3.659).
edge(arl_a6, arl_a7, 3.659).
edge(arl_a6, arl_a5, 6.928).
edge(arl_a5, arl_a6, 6.928).
edge(arl_a5, arl_a4, 7.801).
edge(arl_a4, arl_a5, 7.801).
edge(arl_a4, arl_a3, 7.991).
edge(arl_a3, arl_a4, 7.991).
edge(arl_a3, arl_a2, 9.884).
edge(arl_a2, arl_a3, 9.884).
edge(arl_a2, arl_a1, 6.107).
edge(arl_a1, arl_a2, 6.107).
edge(srt_rn00, srt_rn01, 4.303).
edge(srt_rn01, srt_rn00, 4.303).
edge(srt_rn01, srt_rn02, 3.402).
edge(srt_rn02, srt_rn01, 3.402).
edge(srt_rn02, srt_rn03, 1.952).
edge(srt_rn03, srt_rn02, 1.952).
edge(srt_rn03, srt_rn04, 2.504).
edge(srt_rn04, srt_rn03, 2.504).
edge(srt_rn04, srt_rn05, 5.458).
edge(srt_rn05, srt_rn04, 5.458).
edge(srt_rn05, srt_rn06, 2.808).
edge(srt_rn06, srt_rn05, 2.808).
edge(srt_rn06, srt_rn07, 3.601).
edge(srt_rn07, srt_rn06, 3.601).
edge(srt_rn07, srt_rn08, 9.099).
edge(srt_rn08, srt_rn07, 9.099).
edge(srt_rn08, srt_rn09, 4.647).
edge(srt_rn09, srt_rn08, 4.647).
edge(srt_rw01, srt_rw02, 10.967).
edge(srt_rw02, srt_rw01, 10.967).
edge(srt_rw02, srt_rw03, 6.570).
edge(srt_rw03, srt_rw02, 6.570).
edge(mrt_pk01, mrt_pk02, 1.802).
edge(mrt_pk02, mrt_pk01, 1.802).
edge(mrt_pk02, mrt_pk03, 2.516).
edge(mrt_pk03, mrt_pk02, 2.516).
edge(mrt_pk03, mrt_pk04, 3.204).
edge(mrt_pk04, mrt_pk03, 3.204).
edge(mrt_pk04, mrt_pk05, 2.138).
edge(mrt_pk05, mrt_pk04, 2.138).
edge(mrt_pk05, mrt_pk06, 1.826).
edge(mrt_pk06, mrt_pk05, 1.826).
edge(mrt_pk06, mrt_pk07, 2.139).
edge(mrt_pk07, mrt_pk06, 2.139).
edge(mrt_pk07, mrt_pk08, 2.754).
edge(mrt_pk08, mrt_pk07, 2.754).
edge(mrt_pk08, mrt_pk09, 2.341).
edge(mrt_pk09, mrt_pk08, 2.341).
edge(mrt_pk09, mrt_pk10, 1.955).
edge(mrt_pk10, mrt_pk09, 1.955).
edge(mrt_pk10, mrt_pk11, 2.519).
edge(mrt_pk11, mrt_pk10, 2.519).
edge(mrt_pk11, mrt_pk12, 1.742).
edge(mrt_pk12, mrt_pk11, 1.742).
edge(mrt_pk12, mrt_pk13, 1.946).
edge(mrt_pk13, mrt_pk12, 1.946).
edge(mrt_pk13, mrt_pk14, 1.769).
edge(mrt_pk14, mrt_pk13, 1.769).
edge(mrt_pk14, mrt_pk15, 1.790).
edge(mrt_pk15, mrt_pk14, 1.790).
edge(mrt_pk15, mrt_pk16, 2.021).
edge(mrt_pk16, mrt_pk15, 2.021).
edge(mrt_pk16, mrt_pk17, 1.600).
edge(mrt_pk17, mrt_pk16, 1.600).
edge(mrt_pk17, mrt_pk18, 3.311).
edge(mrt_pk18, mrt_pk17, 3.311).
edge(mrt_pk18, mrt_pk19, 2.037).
edge(mrt_pk19, mrt_pk18, 2.037).
edge(mrt_pk19, mrt_pk20, 1.646).
edge(mrt_pk20, mrt_pk19, 1.646).
edge(mrt_pk20, mrt_pk21, 2.463).
edge(mrt_pk21, mrt_pk20, 2.463).
edge(mrt_pk21, mrt_pk22, 1.871).
edge(mrt_pk22, mrt_pk21, 1.871).
edge(mrt_pk22, mrt_pk23, 2.090).
edge(mrt_pk23, mrt_pk22, 2.090).
edge(mrt_pk23, mrt_pk24, 2.303).
edge(mrt_pk24, mrt_pk23, 2.303).
edge(mrt_pk24, mrt_pk25, 2.699).
edge(mrt_pk25, mrt_pk24, 2.699).
edge(mrt_pk25, mrt_pk26, 2.400).
edge(mrt_pk26, mrt_pk25, 2.400).
edge(mrt_pk26, mrt_pk27, 3.374).
edge(mrt_pk27, mrt_pk26, 3.374).
edge(mrt_pk27, mrt_pk28, 2.069).
edge(mrt_pk28, mrt_pk27, 2.069).
edge(mrt_pk28, mrt_pk29, 2.639).
edge(mrt_pk29, mrt_pk28, 2.639).
edge(mrt_pk29, mrt_pk30, 1.805).
edge(mrt_pk30, mrt_pk29, 1.805).
edge(mrt_mt01, mrt_mt02, 1.754).
edge(mrt_mt02, mrt_mt01, 1.754).
edge(mrt_bl32, mrt_bl01, 2.861).
edge(mrt_bl01, mrt_bl32, 2.861).
edge(mrt_bl01, mrt_bl33, 2.154).
edge(mrt_bl33, mrt_bl01, 2.154).

% ---- transfer(From, To, Minutes): one fact per direction -----------
transfer(arl_a4, mrt_yl11, 8).
transfer(arl_a6, mrt_bl21, 8).
transfer(arl_a8, bts_n2, 8).
transfer(bts_cen, bts_cen_silom, 5).
transfer(bts_cen_silom, bts_cen, 5).
transfer(bts_e15, mrt_yl23, 8).
transfer(bts_e4, mrt_bl22, 8).
transfer(bts_g1, bts_s7, 5).
transfer(bts_n2, arl_a8, 8).
transfer(bts_n8, mrt_bl13, 8).
transfer(bts_n9, mrt_bl14, 8).
transfer(bts_s12, mrt_bl34, 8).
transfer(bts_s2, mrt_bl26, 8).
transfer(bts_s7, bts_g1, 5).
transfer(mrt_bl10, mrt_pp16, 5).
transfer(mrt_bl11, srt_rn00, 8).
transfer(mrt_bl13, bts_n8, 8).
transfer(mrt_bl14, bts_n9, 8).
transfer(mrt_bl15, mrt_yl01, 5).
transfer(mrt_bl21, arl_a6, 8).
transfer(mrt_bl22, bts_e4, 8).
transfer(mrt_bl26, bts_s2, 8).
transfer(mrt_bl34, bts_s12, 8).
transfer(mrt_pk01, mrt_pp11, 5).
transfer(mrt_pk14, srt_rn05, 8).
transfer(mrt_pp11, mrt_pk01, 5).
transfer(mrt_pp15, srt_rw01, 8).
transfer(mrt_pp16, mrt_bl10, 5).
transfer(mrt_yl01, mrt_bl15, 5).
transfer(mrt_yl11, arl_a4, 8).
transfer(mrt_yl23, bts_e15, 8).
transfer(srt_rn00, mrt_bl11, 8).
transfer(srt_rn05, mrt_pk14, 8).
transfer(srt_rw01, mrt_pp15, 8).
transfer(mrt_pk10, mrt_mt01, 5).
transfer(mrt_mt01, mrt_pk10, 5).
transfer(bts_n17, mrt_pk16, 8).
transfer(mrt_pk16, bts_n17, 8).
