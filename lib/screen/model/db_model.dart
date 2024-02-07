class DBModel{
  String? title,notes,amount,category,date,time,status;
  int? id;

  DBModel(
      {this.id,
  this.title,
      this.notes,
      this.amount,
      this.category,
      this.date,
      this.time,
      this.status});

  factory DBModel.mapToModel(Map m1){
    return DBModel(
    id: m1['id'],
      time: m1['time'],
      notes: m1['notes'],
      amount: m1['amount'],
      category: m1['category'],
      date: m1['date'],
      title: m1['title'],
      status: "${m1['status']}",
    );
  }
}