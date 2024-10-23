
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_ui/todo_model.dart';

class ToDoAppUI extends StatefulWidget{
  const ToDoAppUI({super.key});

  @override

  State createState()=> _ToDoAppUIState();
 
}

class _ToDoAppUIState extends State{

     

    TextEditingController titleController=TextEditingController();
    TextEditingController descriptionController=TextEditingController();
    TextEditingController dateController=TextEditingController();
     
     List<ToDoModel> todoCard=[
      ToDoModel(
        title: "JAVA", 
        description: "Exception Handling , Inheritance, OOP, Multithreading, Collection", 
        date: "17 OCT 2024"
        ),

        ToDoModel(
        title: "CPP", 
        description: "Exception Handling , Inheritance, OOP, Pointers, Structure", 
        date: "18 OCT 2024"
        ),

        ToDoModel(
        title: "Dart", 
        description: "Flutter, Interface, Abstract Class, App Development , Collection", 
        date: "19 OCT 2024"
        ),
     ];


  List<Color> cardColor=[

    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1),
  ];


  void submit(bool isedit, [ToDoModel? todoObj]){
    if(titleController.text.trim().isNotEmpty && 
       descriptionController.text.trim().isNotEmpty && 
        dateController.text.isNotEmpty ){

          if(isedit){
            todoObj!.title=titleController.text;
            todoObj.description=descriptionController.text;
            todoObj.date=dateController.text;
          }
          else{

          todoCard.add(
            ToDoModel(
              title: titleController.text, 
              description: descriptionController.text, 
              date: dateController.text
            )
          );
    }
    Navigator.of(context).pop();
    clearText();
    setState(() {
      
    });
        }
  }

  void clearText(){
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  void showBottomSheet(bool isedit,[ToDoModel? todoObj]){

    showModalBottomSheet(

      context: context, 
      isScrollControlled: true,
      builder: (context){
        return Padding(
          padding:  EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top:12,
            left: 12,
            right: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create To-Do",
                    style: GoogleFonts.quicksand(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
          
              Text(
                "Title",
                style: GoogleFonts.quicksand(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(2, 167, 177, 1)
                ),
              ),
          
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
          
               Text(
                "Description",
                style: GoogleFonts.quicksand(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(2, 167, 177, 1)
                ),
              ),
          
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              Text(
                "Date",
                style: GoogleFonts.quicksand(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(2, 167, 177, 1)
                ),
              ),
          
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  suffixIcon: const Icon(Icons.calendar_month)
                ),

                onTap: () async{
                  DateTime? pickedDate = await showDatePicker(
                         context: context, 
                         firstDate: DateTime(2024), 
                          lastDate: DateTime(2025),
                          );
                        String formattedDate=DateFormat.yMMMd().format(pickedDate!);

                      setState(() {
                        dateController.text=formattedDate;
                      });
                },
                
              ),

               const SizedBox(height:20),

                 Center(
                   child: ElevatedButton(
                    onPressed: () {
                       if(isedit==true){
                        submit(true,todoObj);
                       }
                       else{
                        submit(false);
                       }
                      
                    },
                   
                    style: const ButtonStyle(
                   
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(2, 167, 177, 1),
                   
                      ),
                     
                    ),
                   
                    child: Text(
                      "Submit",
                      style: GoogleFonts.quicksand(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ), 
                    ),
                   ),
                 ),
            ],
          ),
        );
      }
      );

  }
    
  
  @override
   

   Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-Do list",
          style: GoogleFonts.quicksand(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white
          ),
        ),
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
     ),

     body: ListView.builder(
      itemCount: todoCard.length,
      itemBuilder: (context, index) {
                    return Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cardColor[index%cardColor.length],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 18),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              "assets/Svg/broken_image.svg",
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                         Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                 todoCard[index].title,
                                style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                  todoCard[index].description,
                                  style: GoogleFonts.quicksand(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), 
                      Row(
                     
                      children: [
                        Text(
                          todoCard[index].date,
                          style: GoogleFonts.quicksand(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),

                       const Spacer(),

                       GestureDetector(
                        onTap: () {

                          titleController.text=todoCard[index].title;
                          descriptionController.text=todoCard[index].description;
                          dateController.text=todoCard[index].date;
                          showBottomSheet(true,todoCard[index] );
                        },
                         child: const Icon(
                            Icons.edit,
                            color:Color.fromRGBO(2, 167, 177, 1),
                          ),
                       ),

                         GestureDetector(
                            onTap: () {
                              todoCard.removeAt(index);
                              setState(() {});
                            },
                           child: const Icon(
                            Icons.delete,
                            color:Color.fromRGBO(2, 167, 177, 1),
                           ),
                         ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showBottomSheet(false);
          },

          backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
          ),
      );
    
   }
}