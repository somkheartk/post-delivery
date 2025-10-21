import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceivingScreen extends StatefulWidget {
  const ReceivingScreen({super.key});

  @override
  State<ReceivingScreen> createState() => _ReceivingScreenState();
}

class _ReceivingScreenState extends State<ReceivingScreen> {
  final List<Parcel> _parcels = [
    Parcel(
      trackingNumber: 'TD1698765432101',
      sender: 'คุณสมชาย ใจดี',
      status: 'พร้อมรับ',
      arrivalDate: DateTime.now().subtract(const Duration(hours: 2)),
      location: 'ศูนย์บริการ สาขาสยาม',
    ),
    Parcel(
      trackingNumber: 'TD1698765432102',
      sender: 'ร้านอาหารแสนอร่อย',
      status: 'พร้อมรับ',
      arrivalDate: DateTime.now().subtract(const Duration(days: 1)),
      location: 'ศูนย์บริการ สาขาสยาม',
    ),
    Parcel(
      trackingNumber: 'TD1698765432103',
      sender: 'ร้านเสื้อผ้าออนไลน์',
      status: 'รับแล้ว',
      arrivalDate: DateTime.now().subtract(const Duration(days: 3)),
      location: 'ศูนย์บริการ สาขาสยาม',
    ),
  ];

  String _selectedFilter = 'ทั้งหมด';

  @override
  Widget build(BuildContext context) {
    final filteredParcels = _selectedFilter == 'ทั้งหมด'
        ? _parcels
        : _parcels.where((p) => p.status == _selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('รับพัสดุ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              _showScanDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'พัสดุของคุณ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('ทั้งหมด'),
                      const SizedBox(width: 8),
                      _buildFilterChip('พร้อมรับ'),
                      const SizedBox(width: 8),
                      _buildFilterChip('รับแล้ว'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredParcels.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 100,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'ไม่มีพัสดุ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredParcels.length,
                    itemBuilder: (context, index) {
                      final parcel = filteredParcels[index];
                      return _buildParcelCard(parcel);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showScanDialog,
        backgroundColor: const Color(0xFFFF6B00),
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('สแกนรับพัสดุ'),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = label;
        });
      },
      backgroundColor: Colors.grey[100],
      selectedColor: const Color(0xFFFF6B00),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      checkmarkColor: Colors.white,
    );
  }

  Widget _buildParcelCard(Parcel parcel) {
    final isPending = parcel.status == 'พร้อมรับ';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          _showParcelDetail(parcel);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      parcel.trackingNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isPending ? Colors.orange[50] : Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      parcel.status,
                      style: TextStyle(
                        color: isPending ? Colors.orange[700] : Colors.green[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    parcel.sender,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    parcel.location,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(parcel.arrivalDate),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              if (isPending) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _confirmReceive(parcel);
                    },
                    child: const Text('รับพัสดุ'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showScanDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('สแกน QR Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.qr_code_scanner,
                size: 100,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'วางกล้องตรงกับ QR Code',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก'),
          ),
        ],
      ),
    );
  }

  void _showParcelDetail(Parcel parcel) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'รายละเอียดพัสดุ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailRow('หมายเลขติดตาม', parcel.trackingNumber),
            const SizedBox(height: 12),
            _buildDetailRow('ผู้ส่ง', parcel.sender),
            const SizedBox(height: 12),
            _buildDetailRow('สถานที่', parcel.location),
            const SizedBox(height: 12),
            _buildDetailRow(
              'วันที่มาถึง',
              DateFormat('dd/MM/yyyy HH:mm').format(parcel.arrivalDate),
            ),
            const SizedBox(height: 12),
            _buildDetailRow('สถานะ', parcel.status),
            if (parcel.status == 'พร้อมรับ') ...[
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _confirmReceive(parcel);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('รับพัสดุ'),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _confirmReceive(Parcel parcel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ยืนยันการรับพัสดุ'),
        content: Text('คุณต้องการรับพัสดุ ${parcel.trackingNumber} หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                parcel.status = 'รับแล้ว';
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('รับพัสดุสำเร็จ'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('ยืนยัน'),
          ),
        ],
      ),
    );
  }
}

class Parcel {
  final String trackingNumber;
  final String sender;
  String status;
  final DateTime arrivalDate;
  final String location;

  Parcel({
    required this.trackingNumber,
    required this.sender,
    required this.status,
    required this.arrivalDate,
    required this.location,
  });
}
