import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const Lapak8App());

const primary = Color(0xFF0037B0);
const primaryButton = Color(0xFF0037B0);
const surface = Color(0xFFFAF8FF);
const field = Color(0xFFF2F3FF);
const secondary = Color(0xFF505F76);
const ink = Color(0xFF131B2E);
const green = Color(0xFF006A48);
const paleGreen = Color(0xFF6FFBBE);

class Lapak8App extends StatelessWidget {
  const Lapak8App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'LAPAK8',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: surface,
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        ),
        home: const StudentDashboard(),
      );
}

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedNav = 0;

  void _showInfo(String title, String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')),
        ],
      ),
    );
  }

  void _showQrTicket() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 14, 24, 28),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 48, height: 5, decoration: BoxDecoration(color: const Color(0xFFC4C5D7), borderRadius: BorderRadius.circular(20))),
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFDAFBEA), borderRadius: BorderRadius.circular(30)),
                child: const Text('Tiket Akses Valid', style: TextStyle(color: green, fontSize: 11, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 8),
              Text('Lab Komputer 2', style: GoogleFonts.outfit(fontSize: 23, fontWeight: FontWeight.w600, color: ink)),
              const SizedBox(height: 6),
              const Text('Tunjukkan kode QR ini kepada PIC Lab saat memasuki ruangan', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: secondary)),
              const SizedBox(height: 20),
              Container(
                width: 190,
                height: 190,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE2E7FF)), borderRadius: BorderRadius.circular(18)),
                child: const _FakeQrCode(),
              ),
              const SizedBox(height: 12),
              const Text('EDURSV-2025-0482', style: TextStyle(color: primary, fontWeight: FontWeight.w700, letterSpacing: 1.1)),
              const SizedBox(height: 22),
              SizedBox(width: double.infinity, height: 48, child: FilledButton(onPressed: () => Navigator.pop(context), style: FilledButton.styleFrom(backgroundColor: field, foregroundColor: ink), child: const Text('Tutup Tiket'))),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              children: [
                _TopBar(onNotifications: () => _showInfo('Notifikasi', 'Belum ada notifikasi baru.')),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 110),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: _Greeting(),
                        ),
                        const SizedBox(height: 14),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: _SummaryCards()),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _SectionTitle(title: 'Peminjaman Terbaru', action: 'Lihat Semua', onTap: () => _showInfo('Peminjaman', 'Daftar peminjaman akan ditampilkan di halaman Pinjaman.')),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _UpcomingCard(onQr: _showQrTicket, onDirections: () => _showInfo('Petunjuk Lab', 'Silakan menuju Lab Komputer 2 dan tunjukkan tiket akses kepada PIC Lab.')),
                        ),
                        const SizedBox(height: 18),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: _SectionTitle(title: 'Aksi Cepat', action: 'Shortcut Edukasi')),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              _QuickAction(icon: Icons.add_box_rounded, label: 'Pinjam\nCepat', color: const Color(0xFF1D4ED8), onTap: () => _showInfo('Pinjam Cepat', 'Pilih fasilitas yang ingin kamu pinjam.')),
                              _QuickAction(icon: Icons.calendar_month_rounded, label: 'Jadwal\nAula', color: const Color(0xFFD0E1FB), iconColor: secondary, onTap: () => _showInfo('Jadwal Aula', 'Jadwal aula akan ditampilkan di sini.')),
                              _QuickAction(icon: Icons.gavel_rounded, label: 'Peraturan\nPeminjaman', color: const Color(0xFFE2E7FF), iconColor: primary, onTap: () => _showInfo('Peraturan Peminjaman', 'Gunakan fasilitas sesuai jadwal dan kembalikan tepat waktu.')),
                              _QuickAction(icon: Icons.support_agent_rounded, label: 'Bantuan\nPIC', color: const Color(0xFF6FFBBE), iconColor: const Color(0xFF004F35), onTap: () => _showInfo('Bantuan PIC', 'Hubungi petugas sarana dan prasarana sekolah.')),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _SectionTitle(title: 'Item Populer', subtitle: 'Sering dipinjam siswa untuk praktikum & ekskul', action: 'Lihat Semua', onTap: () => setState(() => _selectedNav = 1)),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: LayoutBuilder(builder: (context, constraints) {
                            final width = (constraints.maxWidth - 12) / 2;
                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _PopularItem(title: 'DSLR Canon 80D', location: 'Studio Multimedia', units: '2 Unit', image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDQi6ib_b9JDaJEF0sfrFJhYFa6XggzsfQj0kX9NPRBYlI1BYi4WIXIyfBk7IMvFr1RqtbYmUKkZwo6jYrkCbdwKxEbjmZbWME5VFKeOX7h9ZDuFu9VSYZ6AQRV5qHbzo8p3ggW7ZOCbcqLXZsGHW3nfEHOd16DW4ZYH_T8q2LPykmX9U1iPCCAXT9r8kjM3bRR2cZ5cuKQP2rZSSV-YTl92zcQmbWY6SID7XZIi8uuGWTbv6NpLNTe', width: width, onTap: () => _showInfo('DSLR Canon 80D', '2 unit tersedia di Studio Multimedia.')),
                                _PopularItem(title: 'Drawing Tablet', location: 'Lab Desain DKV', units: '6 Unit', image: 'https://images.unsplash.com/photo-1581291518857-4e27b48ff24e?auto=format&fit=crop&w=600&q=80', width: width, onTap: () => _showInfo('Drawing Tablet', '6 unit tersedia di Lab Desain DKV.')),
                                _PopularItem(title: 'Proyektor Epson', location: 'Studio Audio Visual', units: '3 Unit', image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDZu4S04e_mAePsVPS1kM1N9wGxx4pcxEFtSzXLNlITwRjdVhMqz1jEhvbry3OwUONadOzyIW6nSHyXuigHsp4RDo9U-Q5fe2_LDCjORXpR8Ws71OYWzIYRmd-JHjwiPSS-QNRQ0t6Y8sqwOipxqhv2y4hGsEwAR8rOX9WLOHIcK4DSF-VBO-QMVoMDtybhTub_3e71cULJBFh5q4oDgv2cgqGZQsVepOsolm_T5cNuezT11ol2GrhZ', width: width, onTap: () => _showInfo('Proyektor Epson', '3 unit tersedia di Studio Audio Visual.')),
                                _PopularItem(title: 'Proyektor Epson', location: 'Lab RPL • Lantai 2', units: '4 Unit', image: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?auto=format&fit=crop&w=600&q=80', width: width, onTap: () => _showInfo('Proyektor Epson', '4 unit tersedia di Lab RPL lantai 2.')),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _BottomNav(
        selected: _selectedNav,
        onSelect: (index) {
          setState(() => _selectedNav = index);
          if (index != 0) {
            final labels = ['Beranda', 'Fasilitas', 'Pinjaman', 'Riwayat'];
            _showInfo(labels[index], 'Halaman ${labels[index]} bisa kita buat selanjutnya.');
          }
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onNotifications;
  const _TopBar({required this.onNotifications});

  @override
  Widget build(BuildContext context) => Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: surface.withValues(alpha: 0.97), border: const Border(bottom: BorderSide(color: Color(0xFFE9ECF7), width: 0.6))),
        child: Row(
          children: [
            Container(width: 30, height: 30, decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(9)), child: const Icon(Icons.school_rounded, color: Colors.white, size: 19)),
            const SizedBox(width: 8),
            Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [Text('LAPAK8', style: GoogleFonts.outfit(color: primary, fontSize: 14, fontWeight: FontWeight.w700, height: 1.1)), const Text('SMK NEGERI 8 MALANG', style: TextStyle(fontSize: 7, color: secondary, fontWeight: FontWeight.w600, letterSpacing: 0.2))]),
            const Spacer(),
            IconButton(onPressed: onNotifications, tooltip: 'Notifikasi', visualDensity: VisualDensity.compact, icon: const Icon(Icons.notifications_none_rounded, color: secondary, size: 23)),
            const SizedBox(width: 3),
            Container(width: 29, height: 29, decoration: BoxDecoration(color: const Color(0xFFD0E1FB), borderRadius: BorderRadius.circular(50), border: Border.all(color: const Color(0xFFB7C4FF))), child: const Icon(Icons.person_rounded, size: 19, color: primary)),
          ],
        ),
      );
}

class _Greeting extends StatelessWidget {
  const _Greeting();
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Halo, Alifia Zahra', style: GoogleFonts.outfit(fontSize: 18, height: 1.25, fontWeight: FontWeight.w600, color: ink)),
              const SizedBox(height: 5),
              Wrap(spacing: 6, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFD0E1FB), borderRadius: BorderRadius.circular(30)), child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.school_rounded, size: 11, color: secondary), SizedBox(width: 3), Text('Siswa • XII RPL 1', style: TextStyle(fontSize: 9, color: secondary, fontWeight: FontWeight.w700))])),
                const Text('NIS: 2122.10.408', style: TextStyle(fontSize: 9, color: secondary)),
              ]),
            ]),
          ),
          // Ikon centang/verifikasi di sisi kanan dihapus sesuai revisi desain.
        ],
      );
}

class _SummaryCards extends StatelessWidget {
  const _SummaryCards();
  @override
  Widget build(BuildContext context) => Row(children: [
        Expanded(child: _SummaryCard(icon: Icons.task_alt_rounded, count: '1', title: 'Pinjaman Aktif', subtitle: 'Disetujui hari ini', iconBg: paleGreen, iconColor: green, countColor: green)),
        const SizedBox(width: 12),
        Expanded(child: _SummaryCard(icon: Icons.pending_actions_rounded, count: '1', title: 'Menunggu Review', subtitle: 'Verifikasi Sarpras', iconBg: const Color(0xFFD0E1FB), iconColor: secondary, countColor: secondary)),
      ]);
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String count, title, subtitle;
  final Color iconBg, iconColor, countColor;
  const _SummaryCard({required this.icon, required this.count, required this.title, required this.subtitle, required this.iconBg, required this.iconColor, required this.countColor});
  @override
  Widget build(BuildContext context) => Container(
        height: 95,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), boxShadow: const [BoxShadow(color: Color(0x08001340), blurRadius: 8, offset: Offset(0, 2))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Container(width: 25, height: 25, decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle), child: Icon(icon, size: 15, color: iconColor)), const Spacer(), Text(count, style: GoogleFonts.outfit(fontSize: 24, height: 1, fontWeight: FontWeight.w600, color: countColor))]),
          const Spacer(),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: ink)),
          const SizedBox(height: 2),
          Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 8, color: countColor)),
        ]),
      );
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? action;
  final VoidCallback? onTap;
  const _SectionTitle({required this.title, this.subtitle, this.action, this.onTap});
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w600, color: ink)), if (subtitle != null) ...[const SizedBox(height: 2), Text(subtitle!, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 9, color: secondary))]])),
        if (action != null) GestureDetector(onTap: onTap, child: Padding(padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4), child: Text(action!, style: const TextStyle(fontSize: 9, color: primary, fontWeight: FontWeight.w700)))),
      ]);
}

class _UpcomingCard extends StatelessWidget {
  final VoidCallback onQr, onDirections;
  const _UpcomingCard({required this.onQr, required this.onDirections});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), boxShadow: const [BoxShadow(color: Color(0x10001340), blurRadius: 12, offset: Offset(0, 3))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 38, height: 38, decoration: BoxDecoration(color: field, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.computer_rounded, color: primary, size: 23)),
            const SizedBox(width: 9),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(height: 1), Text('Lab Komputer 2', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: ink)), SizedBox(height: 2), Text('Praktik Uji Sertifikasi LSP', style: TextStyle(fontSize: 9, color: secondary))])),
            Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFDAFBEA), borderRadius: BorderRadius.circular(30)), child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.circle, size: 5, color: green), SizedBox(width: 4), Text('Disetujui', style: TextStyle(fontSize: 8, color: green, fontWeight: FontWeight.w700))])),
          ]),
          const SizedBox(height: 10),
          Container(width: double.infinity, padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: field.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(10)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(Icons.schedule_rounded, size: 14, color: primary), SizedBox(width: 5), Expanded(child: Text('Hari ini • 13:30 - 15:30 WIB', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: ink)))]), SizedBox(height: 5), Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.verified_outlined, size: 14, color: green), SizedBox(width: 5), Expanded(child: Text.rich(TextSpan(style: TextStyle(fontSize: 8, color: secondary), children: [TextSpan(text: 'Disetujui oleh: '), TextSpan(text: 'Pak Budi Santoso, S.Kom', style: TextStyle(fontWeight: FontWeight.w700, color: ink)), TextSpan(text: ' (PIC Lab)')])))] )])),
          const SizedBox(height: 9),
          SizedBox(width: double.infinity, height: 34, child: FilledButton.icon(onPressed: onQr, icon: const Icon(Icons.qr_code_2_rounded, size: 16), label: const Text('Tiket Akses QR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)), style: FilledButton.styleFrom(backgroundColor: primaryButton, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 12)))),
          // Tombol utama dibuat biru sesuai revisi warna di Figma.
          // Petunjuk lab tersedia melalui aksi kartu/QR untuk menjaga layout tetap ringkas.
        ]),
      );
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;
  const _QuickAction({required this.icon, required this.label, required this.color, required this.onTap, this.iconColor = Colors.white});
  @override
  Widget build(BuildContext context) => Expanded(child: GestureDetector(onTap: onTap, behavior: HitTestBehavior.opaque, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 2), child: Column(children: [Container(width: 38, height: 38, decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: const [BoxShadow(color: Color(0x08001340), blurRadius: 5, offset: Offset(0, 2))]), child: Icon(icon, color: iconColor, size: 19)), const SizedBox(height: 6), Text(label, textAlign: TextAlign.center, maxLines: 2, style: const TextStyle(fontSize: 8, height: 1.25, color: ink, fontWeight: FontWeight.w600))]))));
}

class _PopularItem extends StatelessWidget {
  final String title, location, units, image;
  final double width;
  final VoidCallback onTap;
  const _PopularItem({required this.title, required this.location, required this.units, required this.image, required this.width, required this.onTap});
  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(21), border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8), boxShadow: const [BoxShadow(color: Color(0x06001340), blurRadius: 6, offset: Offset(0, 2))]),
          clipBehavior: Clip.antiAlias,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AspectRatio(aspectRatio: 1, child: Stack(fit: StackFit.expand, children: [
              Image.network(image, fit: BoxFit.cover, errorBuilder: (context, error, stack) => Container(color: field, child: const Icon(Icons.inventory_2_outlined, color: secondary, size: 38))),
              Positioned(top: 8, right: 7, child: Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.96), borderRadius: BorderRadius.circular(20)), child: Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 5, height: 5, decoration: const BoxDecoration(color: Color(0xFF16A34A), shape: BoxShape.circle)), const SizedBox(width: 4), Text(units, style: const TextStyle(fontSize: 8, color: ink, fontWeight: FontWeight.w700))]))),
            ])),
            Padding(padding: const EdgeInsets.fromLTRB(9, 9, 9, 9), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w700, color: ink)),
              const SizedBox(height: 4),
              Row(children: [const Icon(Icons.location_on_outlined, size: 10, color: primary), const SizedBox(width: 2), Expanded(child: Text(location, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 8, color: secondary)))]),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 27,
                child: FilledButton(
                  onPressed: onTap,
                  style: FilledButton.styleFrom(
                    backgroundColor: primaryButton,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Pinjam',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ])),
          ]),
        ),
      );
}

class _BottomNav extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  const _BottomNav({required this.selected, required this.onSelect});
  @override
  Widget build(BuildContext context) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 7),
          child: Container(
            height: 58,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.97), borderRadius: BorderRadius.circular(22), boxShadow: const [BoxShadow(color: Color(0x14001340), blurRadius: 18, offset: Offset(0, -2))]),
            child: Row(children: [
              _NavItem(icon: Icons.home_rounded, label: 'Beranda', active: selected == 0, onTap: () => onSelect(0)),
              _NavItem(icon: Icons.category_rounded, label: 'Fasilitas', active: selected == 1, onTap: () => onSelect(1)),
              _NavItem(icon: Icons.event_available_rounded, label: 'Pinjaman', active: selected == 2, showDot: selected != 2, onTap: () => onSelect(2)),
              _NavItem(icon: Icons.history_rounded, label: 'Riwayat', active: selected == 3, onTap: () => onSelect(3)),
            ]),
          ),
        ),
      );
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final bool showDot;
  final VoidCallback onTap;
  const _NavItem({required this.icon, required this.label, required this.active, required this.onTap, this.showDot = false});
  @override
  Widget build(BuildContext context) => Expanded(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(icon, size: 19, color: active ? primary : secondary),
                  if (showDot)
                    Positioned(
                      right: -3,
                      top: -1,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: primary,
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(
                            BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 8,
                  color: active ? primary : secondary,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
}

class _FakeQrCode extends StatelessWidget {
  const _FakeQrCode();
  @override
  Widget build(BuildContext context) => CustomPaint(painter: _QrPainter(), child: const SizedBox.expand());
}

class _QrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = ink;
    const cells = 21;
    final cell = size.width / cells;
    final matrix = List.generate(cells, (_) => List.filled(cells, false));
    void finder(int ox, int oy) {
      for (int y = 0; y < 7; y++) {
        for (int x = 0; x < 7; x++) {
          matrix[oy + y][ox + x] = x == 0 || x == 6 || y == 0 || y == 6 || (x >= 2 && x <= 4 && y >= 2 && y <= 4);
        }
      }
    }
    finder(0, 0); finder(14, 0); finder(0, 14);
    for (int y = 0; y < cells; y++) {
      for (int x = 0; x < cells; x++) {
        final inFinder = (x < 7 && y < 7) || (x >= 14 && y < 7) || (x < 7 && y >= 14);
        if (!inFinder) matrix[y][x] = ((x * 7 + y * 11 + x * y) % 5 < 2) || ((x + y) % 7 == 0);
      }
    }
    for (int y = 0; y < cells; y++) {
      for (int x = 0; x < cells; x++) {
        if (matrix[y][x]) canvas.drawRect(Rect.fromLTWH(x * cell, y * cell, cell * 0.94, cell * 0.94), paint);
      }
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
