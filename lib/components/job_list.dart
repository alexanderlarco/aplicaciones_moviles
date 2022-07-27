import 'package:flutter/material.dart';
import 'package:proyecto/models/job.dart';
import 'package:proyecto/components/compact_item_job.dart';

class JobList extends StatelessWidget {
  List<Job> jobs;

  JobList(this.jobs);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: this.jobs.length,
      itemBuilder: (context, index) => CompactItemJob(this.jobs[index]),
    );
  }
}