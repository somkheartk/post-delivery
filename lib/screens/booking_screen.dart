import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _senderNameController = TextEditingController();
  final _senderPhoneController = TextEditingController();
  final _senderAddressController = TextEditingController();
  final _receiverNameController = TextEditingController();
  final _receiverPhoneController = TextEditingController();
  final _receiverAddressController = TextEditingController();
  final _itemDescriptionController = TextEditingController();
  
  String _selectedSize = 'S';
  double _weight = 1.0;

  @override
  void dispose() {
    _senderNameController.dispose();
    _senderPhoneController.dispose();
    _senderAddressController.dispose();
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    _receiverAddressController.dispose();
    _itemDescriptionController.dispose();
    super.dispose();
  }

  double _calculatePrice() {
    double basePrice = 0;
    switch (_selectedSize) {
      case 'S':
        basePrice = 20;
        break;
      case 'M':
        basePrice = 35;
        break;
      case 'L':
        basePrice = 50;
        break;
      case 'XL':
        basePrice = 80;
        break;
    }
    
    if (_weight > 2) {
      basePrice += (_weight - 2) * 5;
    }
    
    return basePrice;
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      final trackingNumber = 'TD${DateTime.now().millisecondsSinceEpoch}';
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 32),
              SizedBox(width: 12),
              Text('จองสำเร็จ'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('การจองของคุณสำเร็จแล้ว'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'หมายเลขติดตาม:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      trackingNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFFFF6B00),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'ค่าส่ง: ${_calculatePrice().toStringAsFixed(2)} บาท',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('ตกลง'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('จองส่งพัสดุ'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('ข้อมูลผู้ส่ง'),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _senderNameController,
                  label: 'ชื่อผู้ส่ง',
                  icon: Icons.person,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _senderPhoneController,
                  label: 'เบอร์โทรศัพท์',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _senderAddressController,
                  label: 'ที่อยู่',
                  icon: Icons.home,
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                _buildSectionTitle('ข้อมูลผู้รับ'),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _receiverNameController,
                  label: 'ชื่อผู้รับ',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _receiverPhoneController,
                  label: 'เบอร์โทรศัพท์',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _receiverAddressController,
                  label: 'ที่อยู่',
                  icon: Icons.home_outlined,
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                _buildSectionTitle('ข้อมูลพัสดุ'),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _itemDescriptionController,
                  label: 'รายละเอียดสินค้า',
                  icon: Icons.inventory_2,
                ),
                const SizedBox(height: 16),
                const Text(
                  'ขนาดพัสดุ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildSizeSelector(),
                const SizedBox(height: 16),
                const Text(
                  'น้ำหนัก (กิโลกรัม)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _weight,
                        min: 0.5,
                        max: 30,
                        divisions: 59,
                        label: '${_weight.toStringAsFixed(1)} kg',
                        activeColor: const Color(0xFFFF6B00),
                        onChanged: (value) {
                          setState(() {
                            _weight = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${_weight.toStringAsFixed(1)} kg',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B00), Color(0xFFFFB800)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'ค่าส่งโดยประมาณ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '฿${_calculatePrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitBooking,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'ยืนยันการจอง',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B00),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFFFF6B00)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFF6B00), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'กรุณากรอก$label';
        }
        return null;
      },
    );
  }

  Widget _buildSizeSelector() {
    return Row(
      children: [
        _buildSizeOption('S', '15x15x15\ncm'),
        const SizedBox(width: 8),
        _buildSizeOption('M', '25x25x25\ncm'),
        const SizedBox(width: 8),
        _buildSizeOption('L', '40x40x40\ncm'),
        const SizedBox(width: 8),
        _buildSizeOption('XL', '60x60x60\ncm'),
      ],
    );
  }

  Widget _buildSizeOption(String size, String dimensions) {
    final isSelected = _selectedSize == size;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedSize = size;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFF6B00) : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFFFF6B00) : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                size,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dimensions,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? Colors.white : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
