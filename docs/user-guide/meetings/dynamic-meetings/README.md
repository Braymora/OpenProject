---
sidebar_navigation:
  title: Dynamic meetings
  priority: 800
description: Manage meetings with agenda and meeting minutes in OpenProject.
keywords: meetings, dynamic meetings, agenda, minutes
---

# Meeting management

Meetings in OpenProject allow you to manage and document your project meetings at one central place, prepare a meeting agenda together with your team and document and share meeting minutes with your meeting attendees at one central place.

<div class="glossary">
**Meetings** is defined as a module that allows the organization of meetings. 

**Note:** in order to be able to use the meetings plugin, the **Meetings module needs to be activated** in the [Project Settings](../projects/project-settings/modules/). </div>


| Topic                                                                     | Content                                     |
|---------------------------------------------------------------------------|---------------------------------------------|
| [Meetings in OpenProject](#meetings-in-openproject)                       | How to open meetings in OpenProject.        |
| [Create a new meeting](#create-a-new-meeting)                             | How to create a new meeting in OpenProject. |
| [Edit a meeting](#edit-a-meeting)                                         | How to edit an existing meeting.            |
| [Add meeting participants](#add-meeting-participants)                     | How to invite people to a meeting.          |
| [Create or edit the meeting agenda](#create-or-edit-the-meeting-agenda)   | How to create or edit the agenda.           |
| [Copy a meeting (recurring meetings)](#copy-a-meeting-recurring-meetings) | How to create recurring meetings.           |

## Meetings in OpenProject

By selecting **Meetings** in the project menu on the left, you get an overview of all the meetings within a specific project sorted by date. By clicking on a meeting name you can view further details of the meeting.

To get an overview of the meetings across multiple projects you can select **Meetings** in the [global modules menu](https://www.openproject.org/docs/user-guide/home/global-modules/).

![Select meetings module from openproject global modules ](openproject_userguide_meetings_module_select.png)

The menu on the left will allow you to filter for upcoming or past meetings. You can also filter the list of the meetings based on your involvement. 

![Meetings overview in openproject global modules](openproject_userguide_dynamic_meetings_overview.png)

## Create a new meeting

You can either create a meeting from within a project, or from the **Meetings** global module. 

> Please note that starting with the 13.1.0 release there will be a choice between creating a classic or dynamic meetings. The default value selected will be a dynamic meeting. In the future, the classic meetings option will be removed.

To create a new meeting, click the green **+ Meeting** button in the upper right corner.

![Create new meeting in OpenProject](openproject_userguide_create_new_meeting.png)

Enter your meeting's title, type, location, start date and duration.

If you are creating a meeting from a global module you will first need to select a project to which the meeting is attributed. After you have selected a project, the list of potential participants (project members) will appear for you to select who to invite. After the meeting you can note who attended the meeting.

Click the blue **Create** button to save your changes.

## Edit a meeting

If you want to change the details of a meeting, for example its time or location, open the meetings details view by clicking on pencil icon next to the **Meeting details**. 

![edit-meeting](openproject_userguide_edit_dynamic_meeting.png)

An edit screen will be displayed and the following meeting information can be adjusted: date, time, duration and location of a meeting.



![edit-meeting](openproject_userguide_edit_screen.png)

Do not forget to save the changes by clicking the green **Save** button. Cancel will bring you back to the details view.

In order to edit the title of the meeting select the dropdown menu behind the three dots and select the **Edit meeting title**.

 ![Edit a meeting title in OpenProject](openproject_userguid_dynamic_meeting_edit_title.png)

## Download a meeting as an iCalendar event

You can download a meeting as an iCalendar event. To do that select the dropdown, same as you would when editing the meeting title and select the **Download iCalendar event**.

 

## Add meeting participants

You will see the list of all the invited project members under **Participants**. You can **add participants** (Invitees and Attendees) to a meeting while being in the [edit mode](#edit-a-meeting). The process is the same whether you are creating a new meeting or editing an existing one. 

![adding meeting participants](openproject_dynamic_meetings_add_participants.png)

You will see the list of all the project members and the based on the check marks next to the name you will be able to tell which project members have been invited. After the meeting you can record who actually took part in it.

![invite meeting participants](openproject_dynamic_meetings_add_new_participants.png)

By removing the check mark you can remove project members from the meetings.

Click on the **Save** button to secure the changes made by you.

## Send email to all participants

You can send an email to all the meeting participants. To do that select the dropdown, same as you would when editing the meeting title and select **Send email to all participants**.

## Create or edit the meeting agenda

After creating a meeting, you can set up a **meeting agenda**.

You can add items to an agenda or directly link work packages by selecting the respective option under the green **Add** button. You can add an agenda time or link directly to an existing work package. 



![](openproject_dynamic_meetings_add_agenda_item.png)

After you have finalized the agenda, you can always edit the agenda items, add notes, move an item or delete it. You can choose the respective option from the menu next each agenda item.

![Edit agenda in OpenProject dynamic meetings](openproject_dynamic_meetings_edit_agenda.png)

The planned duration of each agenda item is automatically summed up. If that sum exceeds the planned duration of the meeting, a warning will appear next to the meeting duration sign. 

![OpenProject meeting too long](openproject_dynamic_meetings_agenda_too_long.png)

## Close a meeting

Once the meeting is closed you can click the **Close meeting**, after this it will no longer be possible to edit the meeting agenda.

![](openproject_userguide_close_meeting.png)

## Re-open a meeting

Once a meeting has been closed, it can no longer be edited. It can be re-opened and edited after that.

![Re-open a meeting in OpenProject](openproject_dynmic_meetings_reopen_meeting.png)

## Delete a meeting

You can delete a meeting. To do that select the dropdown, same as you would when editing the meeting title and select the **Delete meeting**. You will need to confirm that decision.

![Deleting a dynamic meeting in OpenProject](openproject_dynamic_meetings_delete_meeting.png)