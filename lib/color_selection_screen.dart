import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yogita_agarwal_task_impero_it/test_strip_model.dart';

class ColorSelectionScreen extends StatefulWidget {
  const ColorSelectionScreen({super.key});

  @override
  State<ColorSelectionScreen> createState() => _ColorSelectionScreenState();
}

class _ColorSelectionScreenState extends State<ColorSelectionScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllerList =
        List.generate(stripeList.length, (index) => TextEditingController())
            .toList();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black,
                  width: 2,
                )),
                width: 50,
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 70),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 100);
                  },
                  itemCount: stripeList.length,
                  itemBuilder: (context, index) {
                    TestStripeModel model = stripeList[index];
                    return Container(
                      height: 20,
                      width: 60,
                      color: model.colorList
                          .firstWhere(
                            (element) => element.value == model.selectedValue,
                            orElse: () => model.colorList.first,
                          )
                          .color,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 9,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(top: 20),
                itemCount: stripeList.length,
                itemBuilder: (context, topIndex) {
                  TestStripeModel model = stripeList[topIndex];
                  return Flex(
                    direction: Axis.vertical,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            width: 60,
                            child: TextField(
                              onChanged: (value) =>
                                  onValueChanged(topIndex, value),
                              controller: controllerList[topIndex],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 3,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 3,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 3,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 3,
                                  ),
                                ),
                                alignLabelWithHint: true,
                                contentPadding: EdgeInsets.all(10),
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey,
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                              ],
                              key: ValueKey('$topIndex'),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              model.colorList.length,
                              (index) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: InkWell(
                                      onTap: () => onValueChanged(
                                          topIndex,
                                          model.colorList[index].value
                                              .toString()),
                                      child: Flex(
                                        direction: Axis.vertical,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: model
                                                    .colorList[index].color,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                          ),
                                          Text(model.colorList[index].value
                                              .toString()
                                              .replaceAll(regex, ''))
                                        ],
                                      ),
                                    ),
                                  )).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  onValueChanged(int index, String value) {
    ColorModel colorModel = stripeList[index].colorList.firstWhere(
          (element) => double.tryParse(value) == element.value,
        );
    stripeList[index].selectedValue = colorModel.value;
    stripeList[index].SelectedColor = colorModel.color;
    setState(() {});
  }
}
